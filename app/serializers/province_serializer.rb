class ProvinceSerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :locations
  attribute :ballot, if: -> { scope && scope.location } do
    object.active_ballot.nil? ? nil : BallotResultsSerializer.new(object.active_ballot)
  end
end
