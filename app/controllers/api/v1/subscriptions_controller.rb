class Api::V1::SubscriptionsController < ApplicationController
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
    return error("Invalid parameters: Active status is invalid. Please try again") if invalid_params?(params)
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
    params.permit(:price, :frequency, :active)
  end

  def invalid_params?(params)
    return true if params[:active].nil? || params[:id].nil?
  end
end
