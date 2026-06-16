FactoryBot.define do
  factory :comment do
    user
    outfit
    body { "Love this outfit" }
  end
end
