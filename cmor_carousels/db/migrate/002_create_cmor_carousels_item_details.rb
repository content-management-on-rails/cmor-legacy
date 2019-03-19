class CreateCmorCarouselsItemDetails < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_carousels_item_details do |t|
      t.references :carousel, foreign_key: false
      t.references :asset, foreign_key: false
      t.string :url
      t.text :description
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
