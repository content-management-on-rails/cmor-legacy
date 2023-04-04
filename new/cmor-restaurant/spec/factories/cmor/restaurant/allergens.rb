FactoryBot.define do
  factory :cmor_restaurant_allergen, class: Cmor::Restaurant::Allergen do
    sequence(:name) { |n| "Allergen ##{n}" }
    sequence(:identifier) { |n| "allergen_#{n}" }
  end
end
