class VoteSerializer < ActiveModel::Serializer
  attributes :choice_id, :voting_id, :voting_type
end
