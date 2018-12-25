class Poll < ApplicationRecord
  include Voting
  has_many :poll_options
end
