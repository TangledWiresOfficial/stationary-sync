class Api::V1::StatsController < ApplicationController
  skip_before_action :require_auth!

  def index
    render json: {
      users: User.count,
      journeys: Journey.not_soft_deleted.count
    }
  end
end
