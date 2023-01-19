class AddIdentifierToCmorLinksCategories < ActiveRecord::Migration[6.0]
  def change
    add_column :cmor_links_categories, :identifier, :string
  end
end
