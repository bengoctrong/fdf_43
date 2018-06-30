class Suggestion < ApplicationRecord
  enum product_type: {food: 0, drink: 1}
  enum status: {pending: 0, accepted: 1, rejected: 2}

  belongs_to :user

  scope :newest, ->{order(created_at: :desc)}

  validates :product_name, presence: true,
    length: {maximum: Settings.suggestion.name.maximum}
  validates :description, length: {maximum: Settings.suggestion.description.maximum}
  validates :product_type, presence: true
end
