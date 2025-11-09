class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :customer, class_name: "User"
  belongs_to :professional_profile

  validates :rating, inclusion: { in: 1..5 }
end