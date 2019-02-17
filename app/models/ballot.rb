class Ballot < ApplicationRecord
  include Voting

  belongs_to :province, optional: true
  has_and_belongs_to_many :candidates
  has_many :parties, through: :candidates
  has_many :votes, as: :voting

  before_create :feed_results

  private
    def feed_results
      self.results = self.candidates.map{ |c| [c.id, 0] }.to_h
    end
end
