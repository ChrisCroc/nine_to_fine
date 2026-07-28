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

{ "Footwear" => "Shoes", "Top" => "Tops", "Bottom" => "Bottoms",
  "Dress" => "Dresses", "Suit" => "Suits" }.each do |old_name, new_name|
  Category.where(name: old_name, parent_id: nil).update_all(name: new_name)
end

TAXONOMY = {
  "Tops" => %w[tshirt long\ sleeves polo shirt hoodie sweatshirt knitwear tank\ top],
  "Bottoms" => %w[jeans trousers shorts skirt leggings],
  "Outerwear" => %w[coat jacket blazer parka cardigan],
  "Shoes" => %w[sneakers boots dress\ shoes sandals heels],
  "Accessories" => %w[bag belt hat cap beanie scarf jewelry sunglasses],
  "Dresses" => %w[dress jumpsuit],
  "Suits" => %w[suit tuxedo],
  "Swimwear" => %w[swimsuit bikini swim\ shorts]
}.freeze

TAXONOMY.each_with_index do |(parent_name, leaves), p_index|
  parent = Category.find_or_create_by!(name: parent_name) do |c|
    c.position = p_index + 1
    c.parent = nil
  end

  leaves.each_with_index do |leaf_name, l_index|
    Category.find_or_create_by!(name: leaf_name) do |c|
      c.parent = parent
      c.position = l_index + 1
    end
  end
end

puts "Seeding complete! #{Category.parents.count} parents, #{Category.leaves.count} subcategories."
