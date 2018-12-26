class BallotsController < ApplicationController
  def index
    @ballot = Ballot.first
    render json: @ballot, include: ['candidates', 'candidates.party']
  end
end
