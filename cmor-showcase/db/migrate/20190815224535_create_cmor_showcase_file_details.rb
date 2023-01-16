class CreateCmorShowcaseFileDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_showcase_file_details do |t|
      t.references :item, foreign_key: false
      t.references :asset, foreign_key: false
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
