class Journey < ApplicationRecord
  belongs_to :user

  has_many :parts, class_name: "JourneyPart", dependent: :destroy
  validates :parts, length: { minimum: 1 }, unless: :soft_deleted?

  accepts_nested_attributes_for :parts

  validates :timestamp, presence: true, unless: :soft_deleted?
  validates :uuid, presence: true, uniqueness: true

  scope :soft_deleted, -> { where.not(deleted_at: nil) }
  scope :not_soft_deleted, -> { where(deleted_at: nil) }

  def soft_delete!
    update!(deleted_at: Time.now, parts: [], timestamp: nil)
  end

  def soft_deleted?
    Journey.soft_deleted.includes(self)
  end
end
