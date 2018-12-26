class AuthenticationController < ApplicationController
  before_action :authenticate_user, only: [:fetch]

  def authenticate
    token_exchange_url = "https://graph.accountkit.com/v1.1/access_token?grant_type=authorization_code&code=#{params[:code]}&access_token=AA|#{Rails.application.credentials.account_kit[:app_id]}|#{Rails.application.credentials.account_kit[:app_secret]}"
    response = HTTP.get(token_exchange_url).parse

    if response["error"].nil?
      @user = User.find_or_create_by(account_id: response["id"])
      @user.update_attributes(access_token: response["access_token"], access_token_expires_at: DateTime.now() + response["token_refresh_interval_sec"].seconds)

      knock = Knock::AuthToken.new payload: { sub: @user.id }
      
      render json: { token: knock.token, user: @user }, :status => 201
    else
      puts response
      render json: response, :status => 401
    end
  end

  def fetch
    render json: current_user
  end
end
