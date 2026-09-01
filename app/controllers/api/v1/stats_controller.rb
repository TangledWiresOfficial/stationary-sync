class Api::V1::StatsController < ApplicationController
  skip_before_action :require_auth!

  def index
    station_visits = Hash.new(0)
    stations_visited = []

    Journey.not_soft_deleted.each do |journey|
      journey.parts.each_with_index do |part, index|
        station_visits[part.station] += 1
        station_visits[journey.parts[index - 1].station] += 1 if index > 0 # https://github.com/TangledWiresOfficial/Stationary/blob/a88ddccb2c6eb1661e28501ccdc1d86cda934b80/src/utils/station.ts#L23

        stations_visited << part.station
      end
    end

    render json: {
      users: User.count,
      journeys: Journey.not_soft_deleted.count,
      station_visits: station_visits.values.sum,
      stations_visited: stations_visited.uniq.count
    }
  end
end
