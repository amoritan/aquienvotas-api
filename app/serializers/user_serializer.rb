class UserSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :location
  has_many :votes
end
