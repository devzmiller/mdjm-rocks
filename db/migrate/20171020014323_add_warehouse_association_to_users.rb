class AddWarehouseAssociationToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :warehouse_id, :integer
    add_foreign_key :users, :warehouses
  end
end
