class ChangeColumnPriceProduct < ActiveRecord::Migration[5.1]
  def change
    rename_column :products, :prince, :price
  end
end
