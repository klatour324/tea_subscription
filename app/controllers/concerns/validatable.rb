module Validatable
  extend ActiveSupport::Concern

  def invalid_params?
    return true if params[:status].blank? || params[:id].nil?
  end
end
