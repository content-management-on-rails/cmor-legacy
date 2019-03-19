class CreateCmorFilesFileDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_files_file_details do |t|
      t.integer :folder_id
      t.integer :asset_id
      t.string :title
      t.text :description
      t.integer :position

      t.timestamps
    end
  end
end
