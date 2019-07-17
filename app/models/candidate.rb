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
    # if self.avatar.attached?
    #   if Rails.application.config.active_storage.service == :local
    #     Rails.application.routes.url_helpers.url_for(self.avatar.variant(combine_options: { resize: "200x200>", gravity: "Center", crop: "200x200+0+0" }))
    #   else
    #     self.avatar.variant(combine_options: { resize: "200x200>", gravity: "Center", crop: "200x200+0+0" }).service_url.split("?").first
    #   end
    # else
    #   nil
    # end

    self.avatar.attached? ? Rails.application.routes.url_helpers.url_for(self.avatar.variant(combine_options: { resize: "200x200>", gravity: "Center", crop: "200x200+0+0" })) : nil
  end

  attr_accessor :result
end
