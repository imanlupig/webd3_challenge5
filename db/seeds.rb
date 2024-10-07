# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'faker'
require 'csv'

# 676.times do
#   Product.create(
#     title: Faker:: Commerce.product_name,
#     price: Faker:: Commerce.price(range: 0.1..100.0),
#     stock_quantity: Faker::Number.between(from: 1, to: 100)
#   )
# end

# Clear existing data
Product.destroy_all
Category.destroy_all

# Load data from CSV file
csv_file = Rails.root.join('db', 'products.csv')
csv_data = File.read(csv_file)

products = CSV.parse(csv_data, headers: true)

products.each do |row|
  # Find or create the category
  category_name = row['name']
  category = Category.find_or_create_by(name: category_name)

  # Create the product
  category.products.create(
    title: row['title'],
    description: row['description'],
    price: row['price'],
    stock_quantity: row['stock_quantity']
  )
end
