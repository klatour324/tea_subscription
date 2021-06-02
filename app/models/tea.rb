class Tea < ApplicationRecord
  has_many :subscriptions
  has_many :customers, through: :subscriptions

  validates_presence_of :title, presence: true
  validates_presence_of :description, presence: true
  validates_presence_of :temperature, presence: true
  validates_presence_of :brew_time, presence: true
end
