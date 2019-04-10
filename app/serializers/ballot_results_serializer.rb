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



class BallotResultsSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :candidates_with_results

  def candidates_with_results
    object.parties.joins(:candidates).uniq.map { |party|
      party.result = 0
      party.result_candidates = object.candidates.where(party: party).map { |candidate|
        candidate.result = object.results[candidate.id]
        party.result += object.results[candidate.id]
        candidate
      }
      party.result = party.result.round(2)
      PartySerializer.new(party)
    }.sort_by { |party| party.object.result }.reverse
  end
end
