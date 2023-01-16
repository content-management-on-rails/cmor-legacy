class AddSlugToCmorFilesFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_files_folders, :slug, :string
  end
end
