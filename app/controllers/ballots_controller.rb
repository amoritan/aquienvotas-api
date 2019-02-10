class BallotsController < ApplicationController
  before_action :authenticate_user, only: [:vote, :results]

  def index
    @ballot = Ballot.where(status: :active).where(province: nil).order(:created_at).last

    if current_user
      render json: @ballot
    else
      render json: @ballot, include: ['candidates', 'candidates.party']
    end
    
  end

  def show
    @ballot = Ballot.find(params[:id])

    authorize @ballot

    render json: @ballot, include: ['candidates', 'candidates.party']
  end

  def vote
    @ballot = Ballot.find(params[:id])

    authorize @ballot

    @candidate = @ballot.candidates.find(params[:candidate_id])

    @vote = @ballot.votes.find_or_create_by(user: current_user)
    @vote.update_attributes(choice: @candidate)

    render json: @vote
  end
end
