class ApplicationController < ActionController::Base
  add_flash_types :info, :success, :warning, :error

  def current_order_unit
    code = params[:code] || params[:order_unit_code]
    @current_order_unit ||= OrderUnit.find_by(code:)
  end
  helper_method :current_order_unit

  def current_order
    current_order_unit&.order
  end
  helper_method :current_order
end
