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



class Candidate < ApplicationRecord
  include Choice

  belongs_to :party
  has_and_belongs_to_many :ballots
  has_many :votes, as: :choice
  has_one :companion, class_name: "Candidate", foreign_key: "companion_id"

  has_one_attached :avatar

  def avatar_url
    self.avatar.attached? ? self.avatar.variant(combine_options: { resize: "480x480>", gravity: "Center", crop: "480x480+0+0" }).service_url : nil
  end

  attr_accessor :result
end
