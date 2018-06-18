class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :users, through: :rates
  has_many :order_products
  has_many :orders, through: :order_products
end
