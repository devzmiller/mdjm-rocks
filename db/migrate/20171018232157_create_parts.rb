class CreateParts < ActiveRecord::Migration[5.1]
  def change
    create_table :parts do |t|
      t.integer :part_number, null: false
      t.string :name, null: false
      t.integer :max_quantity, null: false

      t.timestamps
    end
  end
end
