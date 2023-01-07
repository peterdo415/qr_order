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
class OrderUnit < ApplicationRecord
  has_one :order, dependent: :restrict_with_error

  validates :code, presence: true

  def qrcode
    qrcode = RQRCode::QRCode.new("https://github.com/")
    svg = qrcode.as_svg(
      color: "000",
      shape_rendering: "crispEdges",
      module_size: 6,
      standalone: true,
      use_path: true
    ).html_safe # rubocop:disable Rails/OutputSafety
  end

  def to_param
    code
  end
end
