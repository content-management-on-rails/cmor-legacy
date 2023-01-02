class CreateCmorLinksLinks < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_links_links do |t|
      t.string :name
      t.string :url
      t.text :description

      # associations
      t.references :category

      # acts as list
      t.integer :position

      t.timestamps
    end
    add_index :cmor_links_links, :category_id
  end
end
