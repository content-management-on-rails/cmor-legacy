# This migration comes from cmor_tags (originally 20160208121254)
class CreateCmorTagsTags < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_tags_tags do |t|
      t.string  'name'
      t.integer 'taggings_count', default: 0
    end

    add_index 'cmor_tags_tags', ['name'], name: 'index_tags_on_name', unique: true
  end
end
