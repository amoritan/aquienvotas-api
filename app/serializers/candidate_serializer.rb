class CandidateSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  attribute :avatar_url, key: :avatar
  belongs_to :party, unless: -> { object.result }
end
