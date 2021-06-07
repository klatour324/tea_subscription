require 'rails_helper'

RSpec.describe 'Cancel a Customers Subscription' do
  describe 'patch request to update status status to cancelled for a customers subscription' do
    before :each do
      @customer = Customer.create!(first_name: "Karen", last_name: "Koko",
                                   email: "name@example.com", street_address: "123 Peppermint St.",
                                   city: "Chicago", state: "IL", zipcode: "60601"
                                  )
      @tea = Tea.create!(title: "Honey Bear Tea", description: "Scrumptious Honeysuckle!", temperature: 202, brew_time: "7 minutes total")
      @subscription = Subscription.create!(status: 'active', title: "One and Only Tea Subscription", price: 99.99, frequency: "Once in a lifetime", customer_id: @customer.id, tea_id: @tea.id)
    end
    describe 'happy path' do
      it 'can update a subscription from active to cancelled' do
        subscription_params = {status: 'cancelled'}

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: JSON.generate(subscription_params)

        result = JSON.parse(response.body, symbolize_names: true)
        subscription1 = Subscription.last

        expect(response).to be_successful
        expect(response.status).to eq(200)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(subscription1.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("customer_subscription")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(6)
        expect(result[:data][:attributes]).to have_key(:customer_id)
        expect(result[:data][:attributes][:customer_id]).to be_an(Integer)
        expect(result[:data][:attributes]).to have_key(:title)
        expect(result[:data][:attributes][:title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:tea_id)
        expect(result[:data][:attributes][:tea_id]).to be_an(Integer)
        expect(result[:data][:attributes]).to have_key(:status)
        expect(result[:data][:attributes][:status]).to eq('cancelled')
        expect(result[:data][:attributes]).to have_key(:frequency)
        expect(result[:data][:attributes][:frequency]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:price)
        expect(result[:data][:attributes][:price]).to be_a(Float)
      end
    end

    describe 'sad path' do
      it 'returns a 400 error response if a valid status is not provided' do
        subscription_params = {status: nil}

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: subscription_params.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Invalid parameters: Please send a valid query parameter"})
      end

      it 'returns a 400 error response if status is left blank' do
        subscription_params = {status: ''}

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: subscription_params.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Status can't be blank"})
      end

      it 'returns a 400 error response if no price exists' do
        subscription_params = {
                                status: 'active',
                                price: '',
                                frequency: 'Weekly'
                              }

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: subscription_params.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Price can't be blank"})
      end

      it 'returns a 400 error response if no frequency exists' do
        subscription_params = {
                                status: 'active',
                                price: 45.99,
                                frequency: ''
                              }

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: subscription_params.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Frequency can't be blank"})
      end

      it 'returns a 400 error response if status is anything other than active or cancelled' do
        subscription_params = {status: 'just kidding'}

        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{@subscription.id}", headers: headers, params: subscription_params.to_json

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(400)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "'just kidding' is not a valid status"})
      end

      it 'returns a 404 error response if the subscription is invalid and does not exist' do
        subscription_id = 1234569230489103858476
        subscription_params = ({status: 'cancelled', price: 49.99, frequency: "Four times a month"})
        headers = {"CONTENT_TYPE" => "application/json"}
        patch "/api/v1/customers/#{@customer.id}/subscriptions/#{subscription_id}", headers: headers, params: JSON.generate(subscription_params)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(response).to_not be_successful
        expect(response.status).to eq(404)
        expect(result).to have_key(:error)
        expect(result).to eq({error: "Couldn't find Subscription with 'id'=1234569230489103858476"})
      end
    end
  end
end
