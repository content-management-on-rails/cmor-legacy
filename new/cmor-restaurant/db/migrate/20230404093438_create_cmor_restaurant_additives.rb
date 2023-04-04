class CreateCmorRestaurantAdditives < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_restaurant_additives do |t|
      t.string :name
      t.string :identifier
      t.text :description
      t.string :position
      t.string :slug
      t.timestamp :published_at

      t.timestamps
    end
  end
end
