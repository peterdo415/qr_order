# == Schema Information
#
# Table name: orders
#
#  id                :bigint           not null, primary key
#  paid_at           :datetime
#  total_with_tax    :decimal(10, )
#  total_without_tax :decimal(10, )
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#  order_unit_id     :bigint           not null
#
# Indexes
#
#  index_orders_on_order_unit_id  (order_unit_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_unit_id => order_units.id)
#
class Order < ApplicationRecord
  belongs_to :order_unit
  has_many :order_details, dependent: :restrict_with_error

  def complete!
    total_without_tax = order_details.joins(:drink).sum('drinks.price')
    update!(
      total_without_tax:,
      total_with_tax:,
      paid_at: Time.zone.now
    )
  end
end
