FactoryBot.define do
  factory :cmor_restaurant_food, class: Cmor::Restaurant::Food do
    association(:category, factory: :cmor_restaurant_category)
    sequence(:name) { |n| "Food ##{n}" }
    sequence(:identifier) { |n| "identifier_#{n}" }
    quantity { 100 }
    unit { "g" }
    price_cents { 500 }
  end
end
