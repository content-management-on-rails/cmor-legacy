class CreateCmorCmsNavigationItems < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_navigation_items do |t|
      t.string :name
      t.string :url
      t.string :key
      t.string :options
      t.text :properties, null: true

      # associations
      t.references :cmor_cms_navigation
      t.references :cmor_cms_page

      # awesome nested set
      t.references :parent
      t.integer :children_count, default: 0, null: false
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      # friendly id
      t.string :slug

      t.timestamps
    end
    add_index :cmor_cms_navigation_items, :cmor_cms_navigation_id
    add_index :cmor_cms_navigation_items, :parent_id
  end
end
