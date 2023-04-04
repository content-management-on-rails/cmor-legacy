module Cmor::Restaurant
  class Allergen < ApplicationRecord
    include ::Cmor::Restaurant::ResourceConcern

    has_many :food_allergens, inverse_of: :allergen, dependent: :destroy
    has_many :foods, through: :food_allergens
  end
end
