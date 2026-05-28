# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Seeding catergories..."
categories = [
  { name: "Top", position: 1 },
  { name: "Bottom", position: 2 },
  { name: "Outerwear", position: 3 },
  { name: "Footwear", position: 4 },
  { name: "Accessories", position: 5 }
]

categories.each do |attributes|
  Category.find_or_create_by!(name: attributes[:name]) do |c|
    c.position = attributes[:position]
  end
end

puts "Seeding complete! #{Category.count} categories in DB."

