# == Schema Information
#
# Table name: order_units
#
#  id         :bigint           not null, primary key
#  code       :string(255)      not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_order_units_on_code  (code) UNIQUE
#
FactoryBot.define do
  factory :order_unit do
    code { "MyString" }
  end
end
