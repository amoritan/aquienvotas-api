class BallotSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :candidates
end
