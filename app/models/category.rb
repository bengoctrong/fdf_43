class Category < ApplicationRecord
  has_many :products
  has_many :subcategories, class_name: :Category, foreign_key: :parent_id, dependent: :destroy

  scope :basic_category, ->{where(parent_id: 0)}
end
