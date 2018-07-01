class Order < ApplicationRecord
  enum status: {pending: 0, accepted: 1, rejected: 2}
  belongs_to :user
  has_many :order_products
  has_many :products, through: :order_products
  accepts_nested_attributes_for :order_products

  delegate :name, :email, :address, to: :user, allow_nil: true

  scope :search_by_status, ->(status){where(status: status) if status.first.present?}
  scope :newest, ->{order(created_at: :desc)}

  def total_price
    order_products.to_a.sum(&:total)
  end
end
