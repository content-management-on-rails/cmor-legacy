class AddIdentifierToCmorFilesFileDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_files_file_details, :identifier, :string
  end
end
