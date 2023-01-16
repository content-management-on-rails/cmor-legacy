class AddLocaleToCmorFilesFolders < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_files_folders, :locale, :string
  end
end
