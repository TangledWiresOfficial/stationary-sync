class Journey < ApplicationRecord
  belongs_to :user

  has_many :parts, class_name: "JourneyPart", dependent: :destroy
  validates :parts, length: { minimum: 1 }

  accepts_nested_attributes_for :parts

  validates :timestamp, presence: true
  validates :uuid, presence: true, uniqueness: true
end
