class CreateOrdersParts < ActiveRecord::Migration[5.1]
  def change
    create_table :orders_parts do |t|
      t.integer :quantity_ordered
      t.integer :quantity_received
      t.belongs_to :part
      t.belongs_to :order

      t.timestamps
    end
  end
end
