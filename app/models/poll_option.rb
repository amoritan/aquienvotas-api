class PollOption < ApplicationRecord
  include Choice

  belongs_to :poll
  has_many :votes, as: :choice

  attr_accessor :result
end
