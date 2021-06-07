class ApplicationController < ActionController::API
  include ErrorHandlers
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ArgumentError, with: :invalid_status
end
