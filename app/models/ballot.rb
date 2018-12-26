class Ballot < ApplicationRecord
  include Voting

  belongs_to :province, optional: true
  has_and_belongs_to_many :candidates
  has_many :parties, through: :candidates
end
