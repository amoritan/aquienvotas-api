class Candidate < ApplicationRecord
  include Choice

  belongs_to :party
  has_and_belongs_to_many :ballots
  has_many :votes, as: :choice

  has_one_attached :avatar

  def avatar_url
    self.avatar.attached? ? Rails.application.routes.url_helpers.url_for(self.avatar.variant(combine_options: {resize: "480x480", gravity: "center", extent: "480x480"})) : nil
  end

  attr_accessor :result
end
