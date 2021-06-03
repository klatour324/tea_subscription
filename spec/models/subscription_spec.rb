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
  end

  describe 'subscription status' do
    before :each do
      @subscription = create(:subscription)
    end

    it 'can have an active status with a valid subscription' do
      @subscription = create(:subscription, active: true)

      expect(@subscription.active).to eq(true)
    end

    it 'can have a cancelled subscription status when subscription is no longer valid' do
      @subscription = create(:subscription, active: false)

      expect(@subscription.active).to eq(false)
    end
  end
end
