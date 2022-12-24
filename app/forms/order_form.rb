class OrderForm
  include ActiveModel::Model
  include ActiveModel::Attributes
  attribute :order
  attribute :order_detail

  class OrderDetails
    include ActiveModel::Model
    include ActiveModel::Attributes
    attribute :order
    attribute :drink_id
    attribute :count, :integer
    validates :drink_id, :count, presence: true

    def save!
      count.times do
        ::OrderDetails.create!(order:, drink_id:)
      end
    end
  end

  
  def create!
    ActiveRecord::Base.transaction do
      @order.save! if @order.new_record?

      @order_unit.each(&:save!)
    end
  end
end
