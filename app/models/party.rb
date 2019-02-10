class Party < ApplicationRecord
  enum status: [ :deleted, :active, :archived ]

  has_many :candidates
  has_many :ballots, through: :candidates

  attr_accessor :result
end
