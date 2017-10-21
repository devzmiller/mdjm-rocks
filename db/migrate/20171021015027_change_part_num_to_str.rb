class ChangePartNumToStr < ActiveRecord::Migration[5.1]
  def change
    change_column :parts, :part_number, :string, null: false
  end
end
