class Subscription < ApplicationRecord
  belongs_to :customer
  belongs_to :tea

  validates_presence_of :title
  validates_presence_of :price
  validates_presence_of :frequency

  def self.active(status)
    where(active: status)
  end
end
