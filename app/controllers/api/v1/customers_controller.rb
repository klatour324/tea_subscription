class Api::V1::CustomersController < ApplicationController
  def create
    customer = Customer.new(customer_params)
    if customer.save
      render json: CustomersSerializer.new(customer), status: :created
    else
      error(customer.errors.full_messages.to_sentence)
    end
  end

  private

  def customer_params
    params.permit(:first_name, :last_name, :email, :street_address, :city, :state, :zipcode)
  end
end
