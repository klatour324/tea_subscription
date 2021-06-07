class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :frequency
  validates_presence_of :status

  enum status: [:active, :cancelled]
end
