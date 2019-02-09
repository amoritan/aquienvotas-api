class ProvinceSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :locations
end
