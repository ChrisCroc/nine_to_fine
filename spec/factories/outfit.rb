FactoryBot.define do
  factory :outfit do
    sequence(:name) { |n| "Outfit #{n}" }
    user

    after(:build) do |outfit, _evaluator|
      if outfit.garments.empty? && outfit.user.present?
        outfit.garments << create(:garment, user: outfit.user)
      end
    end
  end
end
