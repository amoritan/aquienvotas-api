class StatusController < ApplicationController

  def index
    render json: { status: "OK", requested_at: Time.now }
  end
  
end
