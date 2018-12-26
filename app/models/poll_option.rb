class PollOption < ApplicationRecord
  include Choice

  belongs_to :poll
end
