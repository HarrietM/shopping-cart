require 'faker'

User.delete_all
Order.delete_all
Product.delete_all

5.times do
  User.create(name: Faker::Name.name, email: Faker::Internet.email, address: Faker::Address.street_address)
end

10.times do
  Product.create(name: Faker::Commerce.product_name, price: Faker::Commerce.price, description: Faker::Lorem.sentence(4))
end