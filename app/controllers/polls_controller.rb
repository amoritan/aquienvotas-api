class PollsController < ApplicationController
  before_action :authenticate_user, only: [:local, :vote, :results]

  def index
    @polls = Poll.where(status: :active)

    if current_user
      render json: @polls
    else
      render json: @polls, include: ['poll_options']
    end
    
  end

  def show
    @poll = Poll.find(params[:id])

    authorize @poll

    render json: @poll, include: ['poll_options']
  end

  def vote
    @poll = Poll.find(params[:id])

    authorize @poll

    @poll_option = @poll.poll_options.find(params[:poll_option_id])

    @vote = @poll.votes.find_or_create_by(user: current_user)
    @vote.update_attributes(choice: @poll_option)

    render json: @vote
  end
end
