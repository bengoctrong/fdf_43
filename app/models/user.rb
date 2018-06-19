class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i

  has_many :suggestions
  has_many :orders
  has_many :rates
  has_many :products, through: :rates

  validates :name, presence: true, length: {maximum: Settings.user.name.maximum}
  validates :email, presence: true, length: {maximum: Settings.user.email.maximum},
    format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: Settings.password.minimum}

  before_save{self.email = email.downcase}

  has_secure_password
end
