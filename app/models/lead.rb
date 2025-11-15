class Lead < ApplicationRecord
  belongs_to :customer, class_name: "User", optional: true
  belongs_to :professional_profile, optional: true

  enum :status, {
    new: "new",
    contacted: "contacted",
    qualified: "qualified",
    scheduled: "scheduled",
    converted: "converted",
    lost: "lost"
  }, default: "new", _scopes: false

  validates :name, presence: true
  validates :status, presence: true

  scope :pending_follow_up, -> { where.not(follow_up_at: nil).where("follow_up_at >= ?", Time.zone.now.beginning_of_day) }
end