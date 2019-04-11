########################################################################################
########################################################################################
####                                                                                ####
####  This file is part of AQuienVotas.                                             ####
####                                                                                ####
####  AQuienVotas is free software: you can redistribute it and/or modify           ####
####  it under the terms of the GNU Affero General Public License as published by   ####
####  the Free Software Foundation, either version 3 of the License, or             ####
####  (at your option) any later version.                                           ####
####                                                                                ####
####  AQuienVotas is distributed in the hope that it will be useful,                ####
####  but WITHOUT ANY WARRANTY; without even the implied warranty of                ####
####  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the                 ####
####  GNU Affero General Public License for more details.                           ####
####                                                                                ####
####  You should have received a copy of the GNU Affero General Public License      ####
####  along with AQuienVotas.  If not, see <https://www.gnu.org/licenses/>.         ####
####                                                                                ####
########################################################################################
########################################################################################



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

    render json: current_user
  end
end
