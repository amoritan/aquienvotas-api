class BallotsController < ApplicationController
  before_action :authenticate_user, only: [:vote]

  def index
    @ballot = Ballot.where(province: nil).order(:created_at).last
    render json: @ballot, include: ['candidates', 'candidates.party']
  end

  def vote
    @ballot = Ballot.find(params[:id])
    @candidate = Candidate.find(params[:candidate_id])

    @vote = @ballot.votes.find_or_create_by(user: current_user)
    @vote.update_attributes(choice: @candidate)

    render json: @vote
  end
end
