FactoryBot.define do
  factory :category do
    sequence(:name) { |n| "Category #{n}" }
    sequence(:position) { |n| n }
    trait :leaf do
      parent { association(:category) }
    end
  end
end
