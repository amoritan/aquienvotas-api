class PartySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  has_many :candidates
end
