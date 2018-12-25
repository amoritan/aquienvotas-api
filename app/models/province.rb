class Province < ApplicationRecord
  has_many :cities
  has_many :ballots
  has_many :users, through: :cities
end
