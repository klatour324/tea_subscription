class Api::V1::TeasController < ApplicationController
  def create
    tea = Tea.new(tea_params)
    if tea.save
      render json: TeasSerializer.new(tea), status: :created
    else
      error(message)
    end
  end

  private

  def tea_params
    params.permit(:title, :description, :temperature, :brew_time)
  end
end
