class UsersController < ApplicationController
  before_action :authenticate_user

  def update
    @user = User.find(params[:id])
    authorize @user

    @user.update(user_params)
    
    render json: @user
  end

  def demographics
    @users = User.all
    authorize @users

    @response = User.ages.keys.map { |age|
      { age => { 
        :total => (@users.where(age: age).count.to_f * 100 / @users.count.to_f).round(2),
        :genders => User.genders.keys.map { |gender| { gender => (@users.where(age: age).where(gender: gender).count.to_f * 100 / @users.where(age: age).count.to_f).round(2) } }
      } }
    }

    render json: @response
  end

  def locations
    @users = User.all
    authorize @users

    @response = Location.all.map { |location|
      { location.name => (@users.where(location: location).count.to_f * 100 / @users.count.to_f).round(2) }
    }

    render json: @response
  end

  private
    def user_params
      params.require(:user).permit(:location_id, :gender, :age)
    end
end
