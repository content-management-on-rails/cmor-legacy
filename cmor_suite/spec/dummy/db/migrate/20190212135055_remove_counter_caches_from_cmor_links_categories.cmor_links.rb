# This migration comes from cmor_links (originally 20170605034337)
class RemoveCounterCachesFromCmorLinksCategories < ActiveRecord::Migration[5.1]
  def change
    remove_column :cmor_links_categories, :cmor_links_links_count
  end
end
