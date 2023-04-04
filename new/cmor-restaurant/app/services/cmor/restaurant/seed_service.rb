module Cmor
  module Restaurant
    class SeedService < ::SeedService::Base
      class Result < ::SeedService::Result::Base
      end

      private

      def seed_path
        @seed_path ||= Cmor::Restaurant::Engine.root.join("db", "seeds")
      end

      def wipe_scopes
        [
          Cmor::Restaurant::Additive,
          Cmor::Restaurant::Allergen,
          Cmor::Restaurant::Food,
          Cmor::Restaurant::FoodAdditive,
          Cmor::Restaurant::FoodAllergen,
          Cmor::Restaurant::Category
        ]
      end

      def model_name_map
        {
          "additives" => "Cmor::Restaurant::Additive",
          "allergens" => "Cmor::Restaurant::Allergen",
          "foods" => "Cmor::Restaurant::Food",
          "food_additives" => "Cmor::Restaurant::FoodAdditive",
          "food_allergens" => "Cmor::Restaurant::FoodAllergen",
          "categories" => "Cmor::Restaurant::Category"
        }
      end
    end
  end
end
