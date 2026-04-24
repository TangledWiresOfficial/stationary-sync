class JourneyPart < ApplicationRecord
  validates :line, presence: true
  validates_inclusion_of :line, in: GbStationData::LINES

  validates :station, presence: true
  validates_inclusion_of :station, in: GbStationData::STATIONS
end
