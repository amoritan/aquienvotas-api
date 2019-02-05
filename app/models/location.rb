class Location < ApplicationRecord
  belongs_to :province
  has_many :users
end
