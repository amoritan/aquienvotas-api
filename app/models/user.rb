class User < ApplicationRecord
  belongs_to :location, optional: true
  has_one :province, through: :location
  has_many :votes

  enum gender: [ :female, :male, :other ]
  enum age: [ :from16to24, :from25to39, :from40to54, :from55to64, :plus65 ]

  def authenticate(access_token)
    self.access_token == access_token && self.access_token_expires_at > DateTime.now && self
  end
end
