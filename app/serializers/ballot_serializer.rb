class BallotSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :candidates

  def candidates
    object.candidates.shuffle.map { |candidate| CandidateSerializer.new(candidate) }
  end
end
