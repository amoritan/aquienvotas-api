class User < ApplicationRecord
  belongs_to :city
  has_one :province, through: :city
end
