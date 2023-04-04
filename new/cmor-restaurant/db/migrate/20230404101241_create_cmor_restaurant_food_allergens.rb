class CreateCmorRestaurantFoodAllergens < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_restaurant_food_allergens do |t|
      t.references :food, null: false, foreign_key: false
      t.references :allergen, null: false, foreign_key: false

      t.timestamps
    end

    add_foreign_key :cmor_restaurant_food_allergens, :cmor_restaurant_foods, column: :food_id
    add_foreign_key :cmor_restaurant_food_allergens, :cmor_restaurant_allergens, column: :allergen_id
  end
end
