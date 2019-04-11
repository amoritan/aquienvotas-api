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



class UsersController < ApplicationController
  before_action :authenticate_user
  skip_before_action :authenticate_user, only: [:amount]

  def update
    @user = User.find(params[:id])
    authorize @user

    @user.update(user_params)
    
    render json: @user
  end

  def demographics
    @users = User.where.not(gender: nil)
    authorize @users

    @response = User.ages.keys.map { |age|
      {
        :code => age,
        :total => (@users.where(age: age).count.to_f * 100 / @users.count.to_f).round(2),
        :genders => User.genders.keys.map { |gender|
          {
            :code => gender,
            :group => (@users.where(age: age).where(gender: gender).count.to_f * 100 / @users.where(age: age).count.to_f).round(2),
            :total => (@users.where(age: age).where(gender: gender).count.to_f * 100 / @users.count.to_f).round(2)
          }
        }
      }
    }

    render json: @response
  end

  def locations
    @users = User.where.not(location: nil)
    authorize @users

    @response = []

    Province.joins(:locations).each do |province|
      province.locations.each_with_index { |location, index|
        @response << {
          :code => province.locations.count > 1 ? "#{province.code}-#{index + 1}" : province.code,
          :name => location.name,
          :total => (@users.where(location: location).count.to_f * 100 / @users.count.to_f).round(2)
        }
      }
    end

    render json: @response
  end

  def amount
    @users_count = User.all.count

    render json: { users: @users_count }
  end

  private
    def user_params
      params.require(:user).permit(:location_id, :gender, :age)
    end
end
