namespace :voting do

  desc "Count votes for every active ballots"
  task count_ballots: :environment do

    Ballot.where(status: :active).each do |ballot|
      votes = ballot.votes.joins(:user)
      locations = ballot.province.nil? ? Location.all : ballot.province.locations
      population = locations.inject(0){ |sum, location| sum + location.population }
      candidates = ballot.candidates

      results = candidates.map{ |c| [c.id, 0] }.to_h

      locations.each do |location|
        location.demographics.keys.each do |gender|
          location.demographics[gender].each_with_index do |group_population, age|
            group_votes = votes.where(users: { location: location, gender: gender, age: age })
            if group_votes.count > 0
              votes_percentage = Float(group_votes.count.to_f / votes.count.to_f)
              population_percentage = Float(group_population.to_f / population.to_f)
              coefficient = Float(population_percentage / votes_percentage)
              result = votes_percentage * coefficient
              puts "#{location.name}/#{gender}/#{User.ages.key(age)}: #{votes_percentage}/#{population_percentage}/#{coefficient}/#{result}"
              
              candidates.each do |candidate|
                candidate_votes = group_votes.where(choice: candidate)
                candidate_result = candidate_votes.count * result / group_votes.count
                results[candidate.id] += candidate_result
                puts "#{ballot.name}/#{candidate.name}/#{candidate_result}"
              end
            end
          end
        end
      end

      results.keys.each do |result_key|
        results[result_key] = (results[result_key] * 100).round(2)
      end

      ballot.update_attributes(results: results)

    end

  end

  desc "Feed placeholder votes for every active ballots"
  task :feed_ballots, [:votes, :ballot_id, :candidate_id] => :environment do |task, args|

    ballot = Ballot.find(args.ballot_id)
    candidate = Candidate.find(args.candidate_id)

    locations = ballot.province.nil? ? Location.all : ballot.province.locations
    population = locations.inject(0){ |sum, location| sum + location.population }
    candidates = ballot.candidates

    locations.each do |location|
      location.demographics.keys.each do |gender|
        location.demographics[gender].each_with_index do |group_population, age|

          votes = args.votes.to_f * group_population.to_f / population.to_f

          for i in 1..votes.to_i
            user = User.create(location: location, gender: gender, age: age)
            Vote.create(voting: ballot, choice: candidate, user: user)
          end

        end
      end
    end

  end

end
