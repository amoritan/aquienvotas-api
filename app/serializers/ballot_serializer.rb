class BallotSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :candidates, unless: :can_view_results?
  attribute :candidates_with_results, if: :can_view_results?

  def can_view_results?
    scope && !object.deleted? && scope.votes.exists?(voting: object)
  end

  def candidates_with_results
    object.candidates.map { |candidate| candidate.result = object.results[candidate.id] ; CandidateSerializer.new(candidate) }.sort_by { |candidate| candidate.object[:result] }
  end

  def candidates
    object.candidates.shuffle.map { |candidate| CandidateSerializer.new(candidate) }
  end
end
