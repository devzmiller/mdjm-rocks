class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.integer :orderer_id
      t.integer :receiver_id
      t.datetime :received_date
      t.boolean :submitted

      t.timestamps
    end
  end
end
