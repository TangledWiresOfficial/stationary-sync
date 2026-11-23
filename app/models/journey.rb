class Journey < ApplicationRecord
  belongs_to :user

  has_many :parts, class_name: "JourneyPart", dependent: :destroy
  validates :parts, length: { minimum: 1 }, unless: :soft_deleted?

  accepts_nested_attributes_for :parts

  validates :timestamp, presence: true, unless: :soft_deleted?
  validates :uuid, presence: true, uniqueness: { scope: :user_id }

  scope :soft_deleted, -> { where.not(deleted_at: nil) }
  scope :not_soft_deleted, -> { where(deleted_at: nil) }

  def soft_delete!
    update!(deleted_at: Time.now, parts: [], timestamp: nil, description: nil)
  end

  def soft_deleted?
    deleted_at.present?
  end
end
