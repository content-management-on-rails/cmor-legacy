module Cmor::Restaurant
  class FoodAllergen < ApplicationRecord
    belongs_to :food, inverse_of: :food_allergens
    belongs_to :allergen, inverse_of: :food_allergens
  end
end
