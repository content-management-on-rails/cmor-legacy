class AddPublishedAtToCmorCmsPartials < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_cms_partials, :published_at, :timestamp
  end
end
