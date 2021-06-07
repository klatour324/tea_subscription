module Validatable
  extend ActiveSupport::Concern

  def invalid_params?
    return true if params[:status].nil? || params[:id].nil?
  end
end
