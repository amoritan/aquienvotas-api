class User < ApplicationRecord
  belongs_to :city, optional: true
  has_one :province, through: :city
  has_many :votes

  def authenticate(access_token)
    self.access_token == access_token && self.access_token_expires_at > DateTime.now && self
  end
end
