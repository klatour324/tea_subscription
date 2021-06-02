class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true
  validates_presence_of :email, uniqueness: true, presence: true
  validates_presence_of :address, uniqueness: true, presence: true
end
