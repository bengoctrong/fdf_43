class Product < ApplicationRecord
  enum product_type: {food: 0, drink: 1}
  enum is_delete: {exist: 0, deleted: 1}

  attr_accessor :quantity_in_cart, :total_price_in_cart

  belongs_to :category
  has_many :rates
  has_many :users, through: :rates
  has_many :order_products
  has_many :orders, through: :order_products

  scope :load_product_by_ids, ->(ids){where "id IN (?)", ids}
  scope :newest_product, ->{order(created_at: :desc)}

  validates :name, presence: true, length: {maximum: Settings.product.name.maximum}
  validates :description, length: {maximum: Settings.product.description.maximum}
  validates :price, presence: true, numericality: {only_float: true}
  validates :inventory, presence: true,
    numericality: {only_integer: true, greater_than_or_equal_to: Settings.minimum_inventory}
  validates :product_type, presence: true

  scope :actived, ->{where(is_delete: :exist)}
  scope :search_by_name, ->(name){where("name like ?", "#{name}%")}
  scope :search_by_category, ->(category_id){where(category_id: category_id)}
  mount_uploaders :images, ImageUploader

  def change_in_cart quantity
    number = inventory + quantity
    update_attributes inventory: number
  end
end
