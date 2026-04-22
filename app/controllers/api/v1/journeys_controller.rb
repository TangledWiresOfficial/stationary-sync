class Api::V1::JourneysController < ApplicationController
  def index
    render json: @user.journeys
  end
end
