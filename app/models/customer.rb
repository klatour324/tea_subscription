class Customer < ApplicationRecord
  has_many :subscriptions
  has_many :teas, through: :subscriptions

  validates_presence_of :first_name, presence: true
  validates_presence_of :last_name, presence: true
  validates_presence_of :email, uniqueness: true, presence: true
  validates_presence_of :street_address, presence: true
  validates_presence_of :city, presence: true
  validates_presence_of :state, presence: true
  validates_presence_of :zipcode, presence: true
end
