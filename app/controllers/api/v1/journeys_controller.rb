class Api::V1::JourneysController < ApplicationController
  def index
    render json: @user.journeys.as_json(
      include: [ parts: { only: [ :line, :station ] } ],
      only: [ :timestamp, :uuid ]
    )
  end
end
