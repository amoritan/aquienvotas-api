class Province < ApplicationRecord
  has_many :locations
  has_many :ballots
  has_many :users, through: :locations
end
