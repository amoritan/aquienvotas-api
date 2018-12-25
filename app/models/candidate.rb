class Candidate < ApplicationRecord
  include VotingOption

  belongs_to :party
  has_and_belongs_to_many :ballots
end
