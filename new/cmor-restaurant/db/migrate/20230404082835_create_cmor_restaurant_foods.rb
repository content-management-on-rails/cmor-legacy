class CreateCmorRestaurantFoods < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_restaurant_foods do |t|
      t.references :category, null: false, foreign_key: false
      t.string :name
      t.string :identifier
      t.text :description
      t.integer :quantity
      t.string :unit
      t.integer :price_cents
      t.integer :position
      t.string :slug
      t.timestamp :published_at

      t.timestamps
    end

    add_foreign_key :cmor_restaurant_foods, :cmor_restaurant_categories, column: :category_id
  end
end
