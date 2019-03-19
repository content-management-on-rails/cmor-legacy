# This migration comes from cmor_files (originally 20180301094240)
class CreateCmorFilesFolders < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_files_folders do |t|
      t.string :name
      t.timestamp :published_at
      t.text :description

      t.timestamps
    end
  end
end
