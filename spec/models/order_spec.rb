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
require 'rails_helper'

RSpec.describe Order, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
