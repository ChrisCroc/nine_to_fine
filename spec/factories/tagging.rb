FactoryBot.define do
  factory :tagging do
    tag
    taggable { create(:garment) }
  end
end
