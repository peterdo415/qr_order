class OrderUnits::OrderHistoriesController < ApplicationController
  def index
    @order_histories = if current_order.present?
                         select = <<~SQL.squish
                           drinks.name AS drink_name,
                           SUM(drinks.price) AS total,
                           COUNT(order_details.id) AS order_count
                         SQL
                         current_order.order_details.joins(:drink).group(:drink_id).select(select)
                       else
                         []
                       end
  end
end
