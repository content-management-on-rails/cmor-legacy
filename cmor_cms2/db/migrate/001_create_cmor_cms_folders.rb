class CreateCmorCmsFolders < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_folders do |t|
      t.string :basename
      t.string :pathname

      # associations
      t.integer :children_count, default: 0, null: false
      t.integer :cmor_cms_templates_count, default: 0, null: false

      # awesome nested set
      t.references :parent
      t.integer :lft
      t.integer :rgt
      t.integer :depth

      t.timestamps
    end
    add_index :cmor_cms_folders, :parent_id
  end
end
