class ProfessionalProfile < ApplicationRecord
  belongs_to :user
  has_many :bookings, foreign_key: :professional_profile_id
  has_many :leads, dependent: :nullify

  validates :years_experience, :zone, presence: true
end
