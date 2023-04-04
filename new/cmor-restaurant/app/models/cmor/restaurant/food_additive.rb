module Cmor::Restaurant
  class FoodAdditive < ApplicationRecord
    belongs_to :food, inverse_of: :food_additives
    belongs_to :additive, inverse_of: :food_additives
  end
end
