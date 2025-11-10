class User < ApplicationRecord
  has_secure_password

  has_one :professional_profile, dependent: :destroy
  has_many :bookings, foreign_key: :customer_id, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :reviews, foreign_key: :customer_id, dependent: :destroy
  has_many :customer_leads, class_name: "Lead", foreign_key: :customer_id, dependent: :nullify
  has_many :assigned_leads, through: :professional_profile, source: :leads
  has_many :assigned_bookings, through: :professional_profile, source: :bookings

  enum :role, { customer: "customer", professional: "professional", admin: "admin" }, default: "customer"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, allow_blank: true, length: { maximum: 20 }
  validates :address, length: { maximum: 255 }, allow_blank: true
end
