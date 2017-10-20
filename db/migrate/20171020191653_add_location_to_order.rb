class AddLocationToOrder < ActiveRecord::Migration[5.1]
  def change
    add_reference :orders, :warehouse
  end
end
