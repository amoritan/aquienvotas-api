class BallotsController < ApplicationController
  before_action :authenticate_user, only: [:local, :vote]

  def national
    @ballot = Ballot.where(status: :active).where(province: nil).where(status: :active).order(:created_at).last

    render json: @ballot, include: ['candidates', 'candidates.party'], serializer: ballot_serializer
  end

  def local
    @ballot = current_user.province.active_ballot

    render json: @ballot, include: ['candidates', 'candidates.party'], serializer: ballot_serializer
  end

  def show
    @ballot = Ballot.find(params[:id])

    authorize @ballot

    render json: @ballot, include: ['candidates', 'candidates.party'], serializer: ballot_serializer
  end

  def vote
    @ballot = Ballot.find(params[:id])

    authorize @ballot

    @candidate = @ballot.candidates.find(params[:candidate_id])

    @vote = @ballot.votes.find_or_create_by(user: current_user)
    @vote.update_attributes(choice: @candidate)

    render json: current_user
  end

  private
    def ballot_serializer
      (current_user && (current_user.votes.exists?(voting: @ballot) || current_user.votes.where(voting_type: "Ballot").includes(:voting).count {|vote| vote.voting.status == "active" } > 1)) ? BallotResultsSerializer : BallotSerializer
    end
end
