class BallotSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :candidates, unless: :can_view_results?
  attribute :candidates_with_results, if: :can_view_results?

  def can_view_results?
    scope && !object.deleted? && scope.votes.exists?(voting: object)
  end

  def candidates_with_results
    object.parties.joins(:candidates).uniq.map { |party|
      party.result = 0
      party.candidates = object.candidates.where(party: party).map { |candidate|
        candidate.result = object.results[candidate.id]
        party.result += object.results[candidate.id]
        candidate
      }
      party.candidates.sort_by { |candidate| candidate.result }
      party.result = party.result.round(2)
      PartySerializer.new(party)
    }.sort_by { |party| party.object.result }.reverse

  end

  def candidates
    object.candidates.shuffle.map { |candidate| CandidateSerializer.new(candidate) }
  end
end
