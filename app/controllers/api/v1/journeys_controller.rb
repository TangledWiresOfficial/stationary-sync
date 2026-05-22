class Api::V1::JourneysController < ApplicationController
  before_action :set_journey, only: [:show, :update, :destroy]

  def index
    render json: @user.journeys.as_json(
      include: [ parts: { only: [ :line, :station ] } ],
      only: [ :timestamp, :uuid ]
    )
  end

  def create
    @journey = Journey.new(journey_params)
    if @journey.save
      render json: {}, status: :created
    else
      render json: @journey.errors.full_messages, status: :unprocessable_entity
    end
  end

  def show
    @journey.as_json(
      include: [ parts: { only: [ :line, :station ] } ],
      only: [ :timestamp, :uuid ]
    )
  end

  def update
    if @journey.update(journey_params)
      render json: {}, status: :accepted
    else
      render json: @journey.errors.full_messages, status: :unprocessable_entity
    end
  end

  def destroy
    @journey.destroy
  end

  private

  def journey_params
    params.expect(journey: [ :timestamp, :uuid, parts: [ [ :line, :station ] ] ])
  end

  def set_journey
    @journey = Journey.find_by(uuid: params[:uuid])
  end
end
