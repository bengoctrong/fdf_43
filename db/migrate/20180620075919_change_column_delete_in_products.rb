class ChangeColumnDeleteInProducts < ActiveRecord::Migration[5.1]
  def change
    change_column :products, :is_delete, :integer, default: 0
  end
end
