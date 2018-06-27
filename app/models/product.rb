class Product < ApplicationRecord
  enum product_type: {food: 0, drink: 1}
  enum is_delete: {exist: 0, deleted: 1}

  attr_accessor :quantity_in_cart

  belongs_to :category
  has_many :rates
  has_many :users, through: :rates
  has_many :order_products
  has_many :orders, through: :order_products

  scope :load_product_by_ids, ->(ids){where "id IN (?)", ids}

  validates :name, presence: true, length: {maximum: Settings.product.name.maximum}
  validates :description, length: {maximum: Settings.product.description.maximum}
  validates :price, presence: true, numericality: {only_float: true}
  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :product_type, presence: true

  scope :actived, ->{where(is_delete: :exist)}
  mount_uploaders :images, ImageUploader
end
