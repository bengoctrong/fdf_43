class OrderProduct < ApplicationRecord
  belongs_to :order
  belongs_to :product

  delegate :id, :name, :price, to: :product, allow_nil: true
end
