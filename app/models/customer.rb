class Customer < ApplicationRecord
  has_many :teas
  has_many :teas, through: :subscriptions

  validate_presence_of :first_name, presence: true
  validate_presence_of :last_name, presence: true
  validate_presence_of :email, uniqueness: true, presence: true
  validate_presence_of :address, uniqueness: true, presence: true
end
