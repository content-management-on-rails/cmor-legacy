class AddIdentifierToCmorLinksLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :cmor_links_links, :identifier, :string
  end
end
