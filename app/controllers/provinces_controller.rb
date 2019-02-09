class ProvincesController < ApplicationController

  def index
    @provinces = Province.all

    render json: @provinces, include: ['locations']
  end
  
end
