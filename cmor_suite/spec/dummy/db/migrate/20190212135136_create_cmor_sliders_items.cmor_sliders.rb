# This migration comes from cmor_sliders (originally 2)
class CreateCmorSlidersItems < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_sliders_items do |t|
      t.references :slider
      t.integer :position
      t.string :url
      t.text :body
      t.string :markup_language
      t.string :slug

      t.timestamps
    end
  end
end
