namespace :voting do

  desc "Count votes for every active ballots"
  task count_ballots: :environment do

    logger = Logger.new("log/counting_ballots_#{DateTime.now.to_i.to_s}.log")

    Ballot.where(status: :active).each do |ballot|
    # ballot = Ballot.find("78f2b50a-76d4-40ee-94ef-a02ae2f696f2")
      puts "Counting votes for #{ballot.name}"

      votes = ballot.votes.joins(:user)
      locations = ballot.province.nil? ? Location.all : ballot.province.locations
      population = locations.inject(0){ |sum, location| sum + location.population }
      candidates = ballot.candidates

      results = candidates.map{ |c| [c.id, 0] }.to_h

      locations.each do |location|

        puts "  Adding votes at #{location.name}"

        location.demographics.keys.each do |gender|
          location.demographics[gender].each_with_index do |group_population, age|

            puts "    Adding votes for #{gender} / #{User.ages.key(age)}"
            group_votes = votes.where(users: { location: location, gender: gender, age: age })
            if group_votes.count > 0
              votes_percentage = group_votes.count.to_f / votes.count.to_f
              population_percentage = group_population.to_f / population.to_f
              coefficient = population_percentage / votes_percentage

              logger.add(coefficient > 2 || coefficient < -2 ? Logger::WARN : Logger::INFO, "Ballot #{ballot.name} @ #{location.name}/#{gender}/#{User.ages.key(age)}: Obtained #{votes_percentage} / Expected #{population_percentage} / Coefficient #{coefficient}")

              candidates.each do |candidate|
                candidate_votes = group_votes.where(choice: candidate)
                candidate_result = (candidate_votes.count.to_f / votes.count.to_f) * coefficient
                results[candidate.id] += candidate_result
              end
            end
          end
        end

        puts "    Adding votes without demographics"

        location_votes = votes.where(users: { location: location, gender: [nil, :other], age: nil })
        if location_votes.count > 0
          votes_percentage = location_votes.count.to_f / votes.count.to_f
          population_percentage = location.population.to_f / population.to_f
          coefficient = population_percentage / votes_percentage

          logger.add(coefficient > 2 || coefficient < -2 ? Logger::WARN : Logger::INFO, "Ballot #{ballot.name} @ #{location.name}/undefined/undefined}: Obtained #{votes_percentage} / Expected #{population_percentage} / Coefficient #{coefficient}")
          
          candidates.each do |candidate|
            candidate_votes = location_votes.where(choice: candidate)
            candidate_result = (candidate_votes.count.to_f / votes.count.to_f) * coefficient
            results[candidate.id] += candidate_result
          end
        end

      end

      puts "  Adding votes without location"

      spare_votes = votes.where(users: { location: nil, gender: nil, age: nil })
      if ballot.province.nil? && spare_votes.count > 0
        votes_percentage = spare_votes.count.to_f / votes.count.to_f

        logger.info("Ballot #{ballot.name} @ undefined/undefined/undefined}: Obtained #{votes_percentage} / Expected undefined / Coefficient undefined")

        candidates.each do |candidate|
          candidate_votes = spare_votes.where(choice: candidate)
          candidate_result = candidate_votes.count.to_f / votes.count.to_f
          results[candidate.id] += candidate_result
        end
      end

      puts "Saving results for #{ballot.name}"

      results.keys.each do |result_key|
        results[result_key] = (results[result_key] * 100).round(2)
      end

      ballot.update_attributes(results: results)

    end

    logger.close

  end

  desc "Feed placeholder votes for ballot"
  task :feed_ballots, [:votes, :ballot_id, :candidate_id] => :environment do |task, args|

    ballot = Ballot.find(args.ballot_id)
    candidate = Candidate.find(args.candidate_id)

    locations = ballot.province.nil? ? Location.all : ballot.province.locations
    population = locations.inject(0){ |sum, location| sum + location.population }

    locations.each do |location|
      location.demographics.keys.each do |gender|
        location.demographics[gender].each_with_index do |group_population, age|

          votes = args.votes.to_f * group_population.to_f / population.to_f

          for i in 1..votes.round(0)
            user = User.create(location: location, gender: gender, age: age)
            Vote.create(voting: ballot, choice: candidate, user: user)
          end

        end
      end
    end

  end

end
