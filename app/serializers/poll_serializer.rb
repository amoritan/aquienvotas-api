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



class PollSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :poll_options, unless: :can_view_results?
  attribute :poll_options_with_results, if: :can_view_results?

  def can_view_results?
    scope && !object.deleted? && scope.votes.exists?(voting: object)
  end

  def poll_options_with_results
    object.poll_options.map { |poll_option|
      poll_option.result = object.results[poll_option.id]
      PollOptionSerializer.new(poll_option)
    }.sort_by { |poll_option| poll_option.object.result }.reverse
  end

  def poll_options
    object.poll_options.shuffle.map { |poll_option| PollOptionSerializer.new(poll_option) }
  end
end
