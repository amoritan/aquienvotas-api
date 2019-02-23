class Poll < ApplicationRecord
  include Voting

  has_many :poll_options
  has_many :votes, as: :voting

  before_create :feed_results

  private
    def feed_results
      self.results = self.poll_options.map{ |o| [o.id, 0] }.to_h
    end
end
