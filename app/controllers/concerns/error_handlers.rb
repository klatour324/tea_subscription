module ErrorHandlers
  def error(message = "Invalid request error. Please check the request.")
    render json: { error: message }, status: :bad_request
  end

  def record_not_found(exception)
    render json: { error: exception.message }, status: :not_found
  end

  def invalid_status(message = 'Invalid status request. Status must only be active or cancelled')
    render json: { error: message }, status: :bad_request
  end
end
