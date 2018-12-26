class Candidate < ApplicationRecord
  include Choice

  belongs_to :party
  has_and_belongs_to_many :ballots
end
