class MaterialOrder < ApplicationRecord
  belongs_to :booking

  enum :status, {
    pending: "pending",
    ordered: "ordered",
    delivered: "delivered",
    cancelled: "cancelled"
  }, default: "pending"
end