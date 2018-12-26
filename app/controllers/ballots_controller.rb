class BallotsController < ApplicationController
  def national
    @ballot = Ballot.first
    render json: @ballot, include: ['candidates', 'candidates.party']
  end
end
