class ProfessionalProfile < ApplicationRecord
  belongs_to :user
  has_many :bookings, foreign_key: :professional_profile_id

  validates :years_experience, :zone, presence: true
end