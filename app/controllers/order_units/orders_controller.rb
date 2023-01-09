class OrderUnits::OrdersController < ApplicationController
  def create
    @order_form = OrderForm.new(order_unit: current_order_unit, order_params: params[:orders])
    @order_form.create!
    redirect_to order_unit_path(current_order_unit), success: '注文しました'
  end
end
