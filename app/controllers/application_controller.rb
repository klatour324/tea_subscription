class ApplicationController < ActionController::API
  # rescue_from ActiveRecord::RecordNotFound, with: :render_not_found

  def error(message = "Invalid request error. Please check the request.")
    render json: { error: message }, status: :bad_request
  end

  # def record_not_found(exception)
  #   render json: { error: exception.message }, status: :not_found
  # end
end
