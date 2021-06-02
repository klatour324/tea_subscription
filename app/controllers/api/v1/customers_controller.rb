class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: CustomersSerializer.new(customer), status: :created
    else
      render json: {error: "First name, last name, email, street adress, city, state or zipcode cannot be blank"}, status: 400
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :street_address, :city, :state, :zipcode)
  end
end
