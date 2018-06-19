class Product < ApplicationRecord
  belongs_to :category
  has_many :rates
  has_many :users, through: :rates
  has_many :order_products
  has_many :orders, through: :order_products

  validates :name, presence: true, length: {maximum: Settings.product.name.maximum}
  validates :description, length: {maximum: Settings.product.description.maximum}
  validates :price, presence: true, numericality: {only_integer: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :product_type, presence: true
end
