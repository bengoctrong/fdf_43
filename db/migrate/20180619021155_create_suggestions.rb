class CreateSuggestions < ActiveRecord::Migration[5.1]
  def change
    create_table :suggestions do |t|
      t.string :name
      t.string :description
      t.integer :price
      t.string :type
      t.string :status, default: "pending"
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
