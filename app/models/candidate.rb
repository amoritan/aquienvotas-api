class Candidate < ApplicationRecord
  include Choice

  belongs_to :party
  has_and_belongs_to_many :ballots
  has_many :votes, as: :choice
end
