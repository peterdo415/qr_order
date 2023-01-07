class OrderUnits::Orders::CompletesController < ApplicationController
  def create
    current_order.complete!
    redirect_to order_unit_order_histories_path(current_order_unit), success: 'ありがとうございました。お会計はレジにてお願いします。'
  end
end
