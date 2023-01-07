class AddPublishedAtToCmorCmsTemplates < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_cms_templates, :published_at, :timestamp
  end
end
