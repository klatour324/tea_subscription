class Api::V1::SubscriptionsController < ApplicationController
  include Validatable

  def index
    @customer = Customer.find(params[:customer_id])
    render json: SubscriptionSerializer.new(@customer.subscriptions), status: :ok
  end

  def create
    subscription = Subscription.new(subscription_params)
    if subscription.save
      render json: SubscriptionSerializer.new(subscription), status: :created
    else
      error(subscription.errors.full_messages.to_sentence)
    end
  end

  def update
    error = 'Invalid parameters: Please send a valid query parameter'
    return error(error) if invalid_params?
    subscription = Subscription.find(params[:id])
    if subscription.update(updated_subscription_params)
      render json: SubscriptionSerializer.new(subscription), status: :ok
    else
      error(subscription.errors.full_messages.to_sentence)
    end
  end

  private

  def subscription_params
    params.permit(:title, :price, :frequency, :customer_id, :tea_id)
  end

  def updated_subscription_params
    params.permit(:price, :frequency, :status)
  end
end
