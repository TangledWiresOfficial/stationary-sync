class Journey < ApplicationRecord
  belongs_to :user

  has_many :journey_parts, dependent: :destroy
  validates :journey_parts, length: { minimum: 1 }

  accepts_nested_attributes_for :journey_parts

  validates :timestamp, presence: true
  validates :uuid, presence: true, uniqueness: true
end
