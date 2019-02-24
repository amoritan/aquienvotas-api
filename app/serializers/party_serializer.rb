class PartySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  attribute :candidates, if: -> { object.result } do
    object.result_candidates.map { |candidate| CandidateSerializer.new(candidate) }.sort_by { |candidate| candidate.object.result }.reverse
  end
end
