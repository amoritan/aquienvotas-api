class BallotResultsSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :candidates_with_results

  def candidates_with_results
    object.parties.joins(:candidates).uniq.map { |party|
      party.result = 0
      party.result_candidates = object.candidates.where(party: party).map { |candidate|
        candidate.result = object.results[candidate.id]
        party.result += object.results[candidate.id]
        candidate
      }
      party.result = party.result.round(2)
      PartySerializer.new(party)
    }.sort_by { |party| party.object.result }.reverse
  end
end
