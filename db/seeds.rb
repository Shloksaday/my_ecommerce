# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Product.destroy_all

products = [
  {
    name: "Apple iPhone 15",
    price: 79999,
    description: "Latest Apple iPhone with A17 chip and advanced camera system."
  },
  {
    name: "Samsung Galaxy S24",
    price: 74999,
    description: "Flagship Samsung phone with AMOLED display and AI features."
  },
  {
    name: "Sony WH-1000XM5 Headphones",
    price: 29999,
    description: "Industry-leading noise cancellation with premium sound quality."
  },
  {
    name: "Dell XPS 15 Laptop",
    price: 159999,
    description: "High-performance laptop with Intel i7 processor and 4K display."
  },
  {
    name: "Apple Watch Series 9",
    price: 41999,
    description: "Smartwatch with health tracking and fitness features."
  }
]

Product.create!(products)

puts "✅ #{Product.count} products created successfully!"
