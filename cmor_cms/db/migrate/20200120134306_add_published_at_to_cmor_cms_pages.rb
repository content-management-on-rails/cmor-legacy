class AddPublishedAtToCmorCmsPages < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_cms_pages, :published_at, :timestamp
  end
end
