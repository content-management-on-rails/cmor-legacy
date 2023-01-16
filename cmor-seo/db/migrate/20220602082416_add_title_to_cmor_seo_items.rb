class AddTitleToCmorSeoItems < ActiveRecord::Migration[6.0]
  def change
    add_column :cmor_seo_items, :title, :string
  end
end
