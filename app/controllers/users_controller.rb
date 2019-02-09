class UsersController < ApplicationController
  before_action :authenticate_user

  def update
    @user = User.find(params[:id])
    authorize @user

    @user.update(user_params)
    
    render json: @user
  end

  private
    def user_params
      params.require(:user).permit(:location_id, :gender, :age)
    end
end
