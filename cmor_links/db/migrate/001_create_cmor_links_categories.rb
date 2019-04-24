class CreateCmorLinksCategories < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_links_categories do |t|
      t.string :locale
      t.string :name
      t.text :short_description
      t.text :long_description
      t.integer :link_footer_column

      # awesome nested set
      t.integer :lft
      t.integer :rgt
      t.integer :parent_id
      t.integer :depth

      # friendly id
      t.string :slug

      t.timestamps
    end
  end
end
