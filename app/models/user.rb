class User < ApplicationRecord
  has_secure_password

  has_one :professional_profile, dependent: :destroy
  has_many :bookings, foreign_key: :customer_id, dependent: :destroy
  has_many :subscriptions, dependent: :destroy
  has_many :reviews, foreign_key: :customer_id, dependent: :destroy

  enum :role, { customer: "customer", professional: "professional", admin: "admin" }, default: "customer"

  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
end