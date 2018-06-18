class User < ApplicationRecord
  has_many :suggestions
  has_many :orders
  has_many :rates
  has_many :products, through: :rates
end
