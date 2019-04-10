########################################################################################
########################################################################################
####                                                                                ####
####  This file is part of AQuienVotas.                                             ####
####                                                                                ####
####  AQuienVotas is free software: you can redistribute it and/or modify           ####
####  it under the terms of the GNU Affero General Public License as published by   ####
####  the Free Software Foundation, either version 3 of the License, or             ####
####  (at your option) any later version.                                           ####
####                                                                                ####
####  AQuienVotas is distributed in the hope that it will be useful,                ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of                ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 ####
####  GNU Affero General Public License for more details.                           ####
####                                                                                ####
####  You should have received a copy of the GNU Affero General Public License      ####
####  along with AQuienVotas.  If not, see <https://www.gnu.org/licenses/>.         ####
####                                                                                ####
########################################################################################
########################################################################################



namespace :count do

  desc "Count votes for every active ballots"
  task ballots: :environment do

    logger = Logger.new("log/counting_ballots_#{DateTime.now.to_i.to_s}.log")

    Ballot.where(status: :active).each do |ballot|
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

      results_total = results.keys.inject(0){ |sum, candidate_id| sum + results[candidate_id] }
      if (results_total > 0)
        results.keys.each do |result_key|
          results[result_key] = ((results[result_key] / results_total) * 100).round(2)
        end
      end

      ballot.update_attributes(results: results)

    end

    logger.close

  end

  desc "Count votes for every active poll"
  task polls: :environment do

    logger = Logger.new("log/counting_polls_#{DateTime.now.to_i.to_s}.log")

    Poll.where(status: :active).each do |poll|
      puts "Counting votes for #{poll.name}"

      votes = poll.votes.joins(:user)
      locations = Location.all
      population = locations.inject(0){ |sum, location| sum + location.population }
      poll_options = poll.poll_options

      results = poll_options.map{ |c| [c.id, 0] }.to_h

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

              logger.add(coefficient > 2 || coefficient < -2 ? Logger::WARN : Logger::INFO, "Poll #{poll.name} @ #{location.name}/#{gender}/#{User.ages.key(age)}: Obtained #{votes_percentage} / Expected #{population_percentage} / Coefficient #{coefficient}")

              poll_options.each do |poll_option|
                poll_option_votes = group_votes.where(choice: poll_option)
                poll_option_result = (poll_option_votes.count.to_f / votes.count.to_f) * coefficient
                results[poll_option.id] += poll_option_result
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

          logger.add(coefficient > 2 || coefficient < -2 ? Logger::WARN : Logger::INFO, "Poll #{poll.name} @ #{location.name}/undefined/undefined}: Obtained #{votes_percentage} / Expected #{population_percentage} / Coefficient #{coefficient}")
          
          poll_options.each do |poll_option|
            poll_option_votes = location_votes.where(choice: poll_option)
            poll_option_result = (poll_option_votes.count.to_f / votes.count.to_f) * coefficient
            results[poll_option.id] += poll_option_result
          end
        end

      end

      puts "  Adding votes without location"

      spare_votes = votes.where(users: { location: nil, gender: nil, age: nil })
      if spare_votes.count > 0
        votes_percentage = spare_votes.count.to_f / votes.count.to_f

        logger.info("Poll #{poll.name} @ undefined/undefined/undefined}: Obtained #{votes_percentage} / Expected undefined / Coefficient undefined")

        poll_options.each do |poll_option|
          poll_option_votes = spare_votes.where(choice: poll_option)
          poll_option_result = poll_option_votes.count.to_f / votes.count.to_f
          results[poll_option.id] += poll_option_result
        end
      end

      puts "Saving results for #{poll.name}"

      results_total = results.keys.inject(0){ |sum, poll_option_id| sum + results[poll_option_id] }
      if (results_total > 0)
        results.keys.each do |result_key|
          results[result_key] = ((results[result_key] / results_total) * 100).round(2)
        end
      end

      poll.update_attributes(results: results)

    end

    logger.close

  end

end
