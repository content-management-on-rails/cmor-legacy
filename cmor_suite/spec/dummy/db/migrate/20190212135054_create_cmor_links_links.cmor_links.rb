# This migration comes from cmor_links (originally 2)
class CreateCmorLinksLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_links_links do |t|
      t.string :name
      t.string :url
      t.text :description
      t.string :markup_language

      # associations
      t.references :cmor_links_category

      # acts as list
      t.integer :position

      t.timestamps
    end
    add_index :cmor_links_links, :cmor_links_category_id
  end
end
