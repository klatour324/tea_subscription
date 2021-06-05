require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe 'relationships' do
    it { should  belong_to :tea }
    it { should  belong_to :customer }
  end

  describe 'validations' do
    it { should validate_presence_of :title }
    it { should validate_presence_of :price }
    it { should validate_presence_of :frequency }
    it { should define_enum_for :status }
  end

  describe 'subscription status' do
    before :each do
      @subscription = create(:subscription, status: 0)
    end

    it 'can have an active status when a valid subscription is created' do
      expect(@subscription.status).to eq('active')
      expect(@subscription.active?).to eq(true)
      expect(@subscription.cancelled?).to eq(false)
    end

    it 'can have a cancelled subscription status when subscription is updated and no longer valid' do
      @subscription.update(status: 'cancelled')
      
      expect(@subscription.status).to eq('cancelled')
      expect(@subscription.cancelled?).to eq(true)
      expect(@subscription.active?).to eq(false)
    end
  end
end
