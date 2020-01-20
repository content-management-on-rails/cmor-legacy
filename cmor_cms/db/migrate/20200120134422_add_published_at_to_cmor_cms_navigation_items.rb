class AddPublishedAtToCmorCmsNavigationItems < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_cms_navigation_items, :published_at, :timestamp
  end
end
