class ProvincesController < ApplicationController

  def index
    @provinces = Province.all

    if current_user
      render json: @provinces, include: ['locations']
    else
      render json: @provinces
    end
  end
  
end
