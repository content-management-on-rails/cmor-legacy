class AddPublishedAtToCmorFilesFileDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_files_file_details, :published_at, :timestamp
  end
end
