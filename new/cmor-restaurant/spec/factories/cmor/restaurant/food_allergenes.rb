FactoryBot.define do
  factory :cmor_restaurant_food_allergen, class: Cmor::Restaurant::FoodAllergen do
    association(:food, factory: :cmor_restaurant_food)
    association(:allergen, factory: :cmor_restaurant_allergen)
  end
end
