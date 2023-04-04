class CreateCmorRestaurantCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_restaurant_categories do |t|
      t.string :locale
      t.string :identifier
      t.string :name
      t.text :description
      t.string :slug
      t.integer :parent_id, null: true, index: true
      t.integer :lft, null: false, index: true
      t.integer :rgt, null: false, index: true
      t.integer :depth, null: false, default: 0
      t.integer :children_count, null: false, default: 0
      t.timestamp :published_at

      t.timestamps
    end
  end
end
