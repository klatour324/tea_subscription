require 'rails_helper'

RSpec.describe "Get all customer's subscriptions" do
  describe 'happy path' do
    before :each do
      @customer = Customer.create!(first_name: "Karen", last_name: "Koko",
        email: "name@example.com", street_address: "123 Peppermint St.",
        city: "Chicago", state: "IL", zipcode: "60601"
      )
      @tea = Tea.create!(title: "Yummy Tummy Tea", description: "All the mint", temperature: 202, brew_time: "7 minutes total")
      @subscription1 = Subscription.create!(title: "Once in a Lifetime", price: 99.99, frequency: "One time only", customer_id: @customer.id, tea_id: @tea.id)
      @subscription2 = Subscription.create!(title: "Weekly Wintergreen", price: 19.99, frequency: "Once a week", customer_id: @customer.id, tea_id: @tea.id)
      @subscription3 = Subscription.create!(title: "Monthly Menthe", price: 49.99, frequency: "Twice a month", customer_id: @customer.id, tea_id: @tea.id, active: false)
    end

    it "can fetch all of a customer's subscriptions and return both active and cancelled subscriptions" do
      get "/api/v1/customers/#{@customer.id}/subscriptions"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].count).to eq(3)
      expect(result[:data].first).to be_a(Hash)
      expect(result[:data].first.keys).to eq([:id, :type, :attributes])
      expect(result[:data].first[:id]).to be_a(String)
      expect(result[:data].first[:type]).to eq('customer_subscription')
      expect(result[:data].first[:attributes]).to be_a(Hash)
      expect(result[:data].first[:attributes].keys).to eq([:title, :price, :active, :frequency, :customer_id, :tea_id,] )
      expect(result[:data].first[:attributes][:customer_id]).to eq(@customer.id)
      expect(result[:data].first[:attributes][:tea_id]).to eq(@tea.id)
      expect(result[:data].first[:attributes][:title]).to eq("Once in a Lifetime")
      expect(result[:data].first[:attributes][:price]).to eq(99.99)
      expect(result[:data].first[:attributes][:frequency]).to eq("One time only")
      expect(result[:data].first[:attributes][:active]).to eq(true)
    end

    it 'returns an empty array if a customer does not have any current subscriptions' do
      customer = Customer.create!(first_name: "Peter", last_name: "Piper", email: "hello@example.com", street_address: "999 Bovine Rd.", city: "Minneapolis", state: "MN", zipcode: "43210")
      tea = Tea.create!(title: "SleepyTimes", description: "Soothing tea before bed", temperature: 202, brew_time: "4 to 5 minutes")

      get "/api/v1/customers/#{customer.id}/subscriptions"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response.status).to eq(200)
      expect(result).to be_a(Hash)
      expect(result[:data]).to be_an(Array)
      expect(result[:data].count).to eq(0)
    end
  end

  describe 'sad path' do
    it 'returns a 404 error response if a customer does not exist' do
      get "/api/v1/customers/1/subscriptions"

      result = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(result).to eq({error: "Couldn't find Customer with 'id'=1"})

    end
  end
end
