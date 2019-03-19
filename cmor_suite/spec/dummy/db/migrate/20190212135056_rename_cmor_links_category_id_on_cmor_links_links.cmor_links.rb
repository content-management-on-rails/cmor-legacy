# This migration comes from cmor_links (originally 20170605034440)
class RenameCmorLinksCategoryIdOnCmorLinksLinks < ActiveRecord::Migration[5.1]
  def change
    rename_column :cmor_links_links, :cmor_links_category_id, :category_id
  end
end
