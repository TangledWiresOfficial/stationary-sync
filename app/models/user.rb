class User < ApplicationRecord
  has_many :journeys, dependent: :destroy
  has_many :journey_parts, through: :journeys
end
