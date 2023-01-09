class CreateOrderUnits < ActiveRecord::Migration[7.0]
  def change
    create_table :order_units do |t|
      t.string :code, null: false, index: { unique: true }

      t.timestamps
    end
  end
end
