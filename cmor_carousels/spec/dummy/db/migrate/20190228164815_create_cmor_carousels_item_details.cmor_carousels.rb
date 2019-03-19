# This migration comes from cmor_carousels (originally 2)
class CreateCmorCarouselsItemDetails < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_carousels_item_details do |t|
      t.references :carousel, foreign_key: false
      t.references :asset, foreign_key: false
      t.string :url
      t.text :body
      t.string :markup_language
      t.integer :position

      t.timestamps
    end
  end
end
