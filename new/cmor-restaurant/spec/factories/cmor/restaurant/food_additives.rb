FactoryBot.define do
  factory :cmor_restaurant_food_additive, class: Cmor::Restaurant::FoodAdditive do
    association(:food, factory: :cmor_restaurant_food)
    association(:additive, factory: :cmor_restaurant_additive)
  end
end
