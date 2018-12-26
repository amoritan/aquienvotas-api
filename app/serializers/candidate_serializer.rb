class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color
  belongs_to :party
end
