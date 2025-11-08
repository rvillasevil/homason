class SubscriptionPlan < ApplicationRecord
  has_many :subscriptions
  scope :active, -> { where(active: true) }
end
