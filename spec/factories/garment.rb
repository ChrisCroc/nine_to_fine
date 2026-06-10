FactoryBot.define do
  factory :garment do
    sequence(:name) { |n| "Garment #{n}" }
    color { "black" }
    user
    category
  end
end
