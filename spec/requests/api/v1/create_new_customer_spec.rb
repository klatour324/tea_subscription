require 'rails_helper'

RSpec.describe 'Create a new customer' do
  describe 'post request to create a new customer' do
    describe 'happy path' do
      it 'can create a new customer with all its attributes' do
        customer_params = ({
          first_name: "Joe",
          last_name: "Shmoe",
          email: "whatever@example.com",
          street_address: "123 Peach St.",
          city: "Denver",
          state: "CO",
          zipcode: "80110"
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/customers", headers: headers, params: JSON.generate(customer_params)

        result = JSON.parse(response.body, symbolize_names: true)
        customer1 = Customer.last

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(customer1.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("customer")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(7)
        expect(result[:data][:attributes]).to have_key(:first_name)
        expect(result[:data][:attributes][:first_name]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:last_name)
        expect(result[:data][:attributes][:last_name]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:email)
        expect(result[:data][:attributes][:email]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:street_address)
        expect(result[:data][:attributes][:street_address]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:city)
        expect(result[:data][:attributes][:city]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:state)
        expect(result[:data][:attributes][:state]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:zipcode)
        expect(result[:data][:attributes][:zipcode]).to be_a(String)
      end
    end
  end
end
