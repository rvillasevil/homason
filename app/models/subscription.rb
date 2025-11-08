class Subscription < ApplicationRecord
  belongs_to :user
  belongs_to :subscription_plan
  has_many :bookings

  scope :active, -> { where(active: true) }
end