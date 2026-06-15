FactoryBot.define do
  factory :like do
    user
    association :likeable, factory: :outfit
  end
end
