# == Schema Information
#
# Table name: order_details
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  drink_id   :bigint           not null
#  order_id   :bigint           not null
#
# Indexes
#
#  index_order_details_on_drink_id  (drink_id)
#  index_order_details_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (drink_id => drinks.id)
#  fk_rails_...  (order_id => orders.id)
#
require 'rails_helper'

RSpec.describe OrderDetail, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
