class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  belongs_to :party
end
