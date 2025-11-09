class Booking < ApplicationRecord
  belongs_to :customer, class_name: "User"
  belongs_to :professional_profile, optional: true
  belongs_to :subscription, optional: true

  has_one :material_order, dependent: :destroy
  has_one :review, dependent: :destroy

  enum :status, {
    pending: "pending",
    confirmed: "confirmed",
    completed: "completed",
    cancelled: "cancelled"
  }, default: "pending"

  validates :date, :days, :address, :description, presence: true
  validates :days, numericality: { greater_than: 0 }
end