class UserSerializer < ActiveModel::Serializer
  attributes :id, :gender, :age
  belongs_to :location
  has_many :votes
  attribute :admin, if: -> { object.admin? }
end
