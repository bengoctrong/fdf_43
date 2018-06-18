class CreateOrders < ActiveRecord::Migration[5.1]
  def change
    create_table :orders do |t|
      t.string :address_ship
      t.string :status, default: "new"
      t.integer :total
      t.text :note
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
