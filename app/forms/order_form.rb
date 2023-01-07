class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :order
  attribute :order_detail

  class OrderDetail
    include ActiveModel::Model
    include ActiveModel::Attributes
    attribute :order
    attribute :drink_id
    attribute :count, :integer
    validates :drink_id, :count, presence: true

    def save!
      count.times do
        ::OrderDetail.create!(order:, drink_id:)
      end
    end
  end

  def initialize(order_unit:, order_params:)
    @order = order_unit.order || order_unit.build_order
    order_details = []
    order_params.select { |_, order_attribute| order_attribute[:count].to_i.positive? }.each do |_, order_attribute|
      order_details << OrderForm::OrderDetail.new(drink_id: order_attribute[:drink_id],
                                                  count: order_attribute[:count].to_i, order: @order)
    end
    @order_details = order_details
  end

  def create!
    ActiveRecord::Base.transaction do
      @order.save! if @order.new_record?

      @order_details.each(&:save!)
    end
  end
end
