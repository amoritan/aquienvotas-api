class PollSerializer < ActiveModel::Serializer
  attributes :id, :name
  attribute :poll_options, unless: :can_view_results?
  attribute :poll_options_with_results, if: :can_view_results?

  def can_view_results?
    scope && !object.deleted? && scope.votes.exists?(voting: object)
  end

  def poll_options_with_results
    object.poll_options.map { |poll_option|
      poll_option.result = object.results[poll_option.id]
      PollOptionSerializer.new(poll_option)
    }.sort_by { |poll_option| poll_option.object.result }.reverse
  end

  def poll_options
    object.poll_options.shuffle.map { |poll_option| PollOptionSerializer.new(poll_option) }
  end
end
