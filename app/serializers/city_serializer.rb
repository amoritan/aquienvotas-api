class CitySerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :province
end
