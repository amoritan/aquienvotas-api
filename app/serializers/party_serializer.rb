class PartySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  has_many :candidates do
    object.candidates.sort_by { |candidate| candidate.result }.reverse
  end 
end
