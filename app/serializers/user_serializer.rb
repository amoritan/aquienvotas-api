class UserSerializer < ActiveModel::Serializer
  attributes :id
  belongs_to :city
  has_many :votes
end
