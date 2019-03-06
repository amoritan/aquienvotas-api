class Admin::BallotsController < AdminController
  before_action :authenticate_user

  def index
    @ballots = policy_scope(Ballot)

    render json: @ballots
  end

  def show
    @ballot = Ballot.find(params[:id])

    authorize @ballot

    render json: @ballot
  end

end
