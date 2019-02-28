class UsersController < ApplicationController
  before_action :authenticate_user

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
    @users = User.where.not(province: nil)
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

  private
    def user_params
      params.require(:user).permit(:location_id, :gender, :age)
    end
end
