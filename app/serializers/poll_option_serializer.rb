class PollOptionSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
end
