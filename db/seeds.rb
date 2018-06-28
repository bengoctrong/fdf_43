# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.create!(name: "Trong",
  email: "trongngoc@gmail.com",
  password: "trong123",
  password_confirmation: "trong123",
  status: "activated",
  role: "admin",
  activated_at: Time.zone.now)

User.create!(name: "Song",
  email: "songtranvan2511@gmail.com",
  password: "123456",
  password_confirmation: "123456",
  status: "activated",
  role: "admin",
  activated_at: Time.zone.now)

21.times do |n|
  name = Faker::Name.name
  email = "user#{n+1}@gmail.com"
  password = "123456"
  User.create!(name: name,
  email: email,
  password: password,
  password_confirmation: password,
  status: "activated",
  activated_at: Time.zone.now)
end

3.times do |n|
  Category.create!(name: "cate#{n}")
end

10.times do |n|
  name = "Product#{n+1}"
  description = "AAA#{n}"
  price = 10
  quantity = 10
  Product.create!(name: name,
    description: description,
    price: price,
    inventory: quantity,
    category_id: 1)
end

