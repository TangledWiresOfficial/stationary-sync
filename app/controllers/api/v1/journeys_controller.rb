class Api::V1::JourneysController < ApplicationController
  before_action :set_journey, only: [ :show, :update, :destroy ]

  def index
    render json: @user.journeys.not_soft_deleted.as_json(
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
    render json: @journey.as_json(
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
    if @journey.soft_delete
      head :no_content
    else
      render json: @journey.errors.full_messages, status: :unprocessable_entity
    end
  end

  def sync
    ActiveRecord::Base.transaction do
      sync_params[:deleted_uuids].each do |uuid|
        next if uuid.blank?
        @user.journeys.find_by(uuid: uuid)&.soft_delete!
      end

      sync_params[:journeys].each do |journey|
        next if journey.blank?
        @user.journeys.find_or_initialize_by(uuid: journey[:uuid]).update!(journey)
      end
    end

    render json: @user.journeys.not_soft_deleted.as_json(
      include: [ parts: { only: [ :line, :station ] } ],
      only: [ :timestamp, :uuid ]
    )
  end

  private

  def journey_params
    params.expect(journey: [ :timestamp, :uuid, parts_attributes: [ [ :line, :station ] ] ])
  end

  def sync_params
    deleted_uuids, journeys = params.expect(deleted_uuids: [], journeys: [ [ :timestamp, :uuid, parts_attributes: [ [ :line, :station ] ] ] ])

    { deleted_uuids:, journeys: }
  end

  def set_journey
    @journey = Journey.find_by(uuid: params[:id])
  end
end
