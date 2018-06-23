class Order < ApplicationRecord
  enum status: {added: 0, pending: 1, purchased: 2}
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products

  delegate :name, :email, :address, to: :user, allow_nil: true

  scope :find_by_status_add, ->{where status: :added}

  def add_product product_id
    order_product = order_products.find_by product_id: product_id
    order_product ? increase_quantity(order_product) : (order_product = order_products.build product_id: product_id)
    order_product
  end

  def increase_quantity order_product
    order_product.quantity += Settings.increase_quantity
  end
end
