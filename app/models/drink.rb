# == Schema Information
#
# Table name: drinks
#
#  id         :bigint           not null, primary key
#  name       :string(255)      not null
#  price      :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Drink < ApplicationRecord
  validates :name, presence: true
end
