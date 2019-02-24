class PartySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :color, :result
  attribute :candidates do
    object.result_candidates.map { |candidate| CandidateSerializer.new(candidate) }.sort_by { |candidate| candidate.object.result }.reverse
  end 
end
