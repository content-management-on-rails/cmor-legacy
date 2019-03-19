# This migration comes from cmor_tags (originally 20190301132031)
class AddColorToTags < ActiveRecord::Migration[5.2]
  def change
    add_column :tags, :color, :string
  end
end
