class Ballot < ApplicationRecord
  include Voting

  belongs_to :province, optional: true
  has_many :candidates
  has_many :parties, through: :candidates
end
