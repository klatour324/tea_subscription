require 'rails_helper'

RSpec.describe 'Subscribe a Customer to a Tea' do
  describe 'post request to create a customers subscription' do
    before :each do
      @customer = Customer.create!(first_name: "Karen", last_name: "Koko",
        email: "name@example.com", street_address: "123 Peppermint St.",
        city: "Chicago", state: "IL", zipcode: "60601"
      )
      @tea = Tea.create!(title: "Honey Bear Tea", description: "Scrumptious Honeysuckle!", temperature: 202, brew_time: "7 minutes total")
    end
    describe 'happy path' do
      it 'can create a subscription for a specific customer' do
        subscription_params = ({
          customer_id: @customer.id,
          tea_id: @tea.id,
          title: "Tea Bonanza Monthly Subscription",
          price: 39.99,
          frequency: "Twice a month"
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

        result = JSON.parse(response.body, symbolize_names: true)
        subscription1 = Subscription.last

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(subscription1.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("subscription")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(6)
        expect(result[:data][:attributes]).to have_key(:title)
        expect(result[:data][:attributes][:title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:customer_id)
        expect(result[:data][:attributes][:customer_id]).to be_an(Integer)
        expect(result[:data][:attributes]).to have_key(:tea_id)
        expect(result[:data][:attributes][:tea_id]).to be_an(Integer)
        expect(result[:data][:attributes]).to have_key(:active)
        expect(result[:data][:attributes][:active]).to eq(true)
        expect(result[:data][:attributes]).to have_key(:frequency)
        expect(result[:data][:attributes][:frequency]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:price)
        expect(result[:data][:attributes][:price]).to be_a(Float)
      end
    end

    describe 'sad path' do
      it 'returns a 400 error response if no request body is provided' do
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers

        result = JSON.parse(response.body, symbolize_names: true)
        subscription1 = Subscription.last

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Tea must exist, Title can't be blank, Price can't be blank, and Frequency can't be blank"})
      end

      it 'cannot create a subscription with invalid input for any field' do

        subscription_params = ({
          customer_id: @customer.id,
          tea_id: @tea.id,
          title: "Tea Bonanza Monthly Subscription",
          price: [],
          frequency: "Twice a month"
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/customers/#{@customer.id}/subscriptions", headers: headers, params: JSON.generate(subscription_params)

        result = JSON.parse(response.body, symbolize_names: true)
        subscription1 = Subscription.last

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Price can't be blank"})
      end
    end
  end
end
