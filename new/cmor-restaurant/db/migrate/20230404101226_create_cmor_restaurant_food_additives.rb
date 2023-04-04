class CreateCmorRestaurantFoodAdditives < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_restaurant_food_additives do |t|
      t.references :food, null: false, foreign_key: false
      t.references :additive, null: false, foreign_key: false

      t.timestamps
    end

    add_foreign_key :cmor_restaurant_food_additives, :cmor_restaurant_foods, column: :food_id
    add_foreign_key :cmor_restaurant_food_additives, :cmor_restaurant_additives, column: :additive_id
  end
end
