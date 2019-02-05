class LocationSerializer < ActiveModel::Serializer
  attributes :id, :name
  belongs_to :province
end
