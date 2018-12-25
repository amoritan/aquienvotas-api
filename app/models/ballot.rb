class Ballot < ApplicationRecord
  include Voting

  belongs_to :province, optional: true
end
