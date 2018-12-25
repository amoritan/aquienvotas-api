class PollOption < ApplicationRecord
  include VotingOption

  belongs_to :poll
end
