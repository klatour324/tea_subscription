require 'rails_helper'

RSpec.describe 'Create a New Tea' do
  describe 'post request to create a new tea' do
    describe 'happy path' do
      it 'can create a new tea with all its attributes' do
        tea_params = ({
          title: "Happy Yummy Tummy Tea",
          description: "Earl Grey calming tea",
          temperature: 198.10,
          brew_time: "7 minutes total"
          })
        headers = {"CONTENT_TYPE" => "application/json"}
        post "/api/v1/teas", headers: headers, params: JSON.generate(tea_params)

        result = JSON.parse(response.body, symbolize_names: true)
        tea1 = Tea.last

        expect(response).to be_successful
        expect(response.status).to eq(201)
        expect(result).to be_a(Hash)
        expect(result[:data]).to be_a(Hash)
        expect(result[:data].count).to eq(3)
        expect(result[:data]).to have_key(:id)
        expect(result[:data][:id]).to be_a(String)
        expect(result[:data][:id]).to eq(tea1.id.to_s)
        expect(result[:data]).to have_key(:type)
        expect(result[:data][:type]).to eq("teas")
        expect(result[:data]).to have_key(:attributes)
        expect(result[:data][:attributes]).to be_a(Hash)
        expect(result[:data][:attributes].count).to eq(4)
        expect(result[:data][:attributes]).to have_key(:title)
        expect(result[:data][:attributes][:title]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:description)
        expect(result[:data][:attributes][:description]).to be_a(String)
        expect(result[:data][:attributes]).to have_key(:temperature)
        expect(result[:data][:attributes][:temperature]).to be_a(Float)
        expect(result[:data][:attributes]).to have_key(:brew_time)
        expect(result[:data][:attributes][:brew_time]).to be_a(String)
      end
    end
  end
end
