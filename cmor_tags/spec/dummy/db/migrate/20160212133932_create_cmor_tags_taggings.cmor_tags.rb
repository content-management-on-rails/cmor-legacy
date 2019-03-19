# This migration comes from cmor_tags (originally 20160208121300)
# This migration comes from cmor_tags (originally 20160208121300)
class CreateCmorTagsTaggings < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_tags_taggings do |t|
      t.integer  'tag_id'
      t.integer  'taggable_id'
      t.string   'taggable_type'
      t.integer  'tagger_id'
      t.string   'tagger_type'
      t.string   'context', limit: 128
      t.datetime 'created_at'
    end

    add_index 'cmor_tags_taggings', %w(tag_id taggable_id taggable_type context tagger_id tagger_type), name: 'taggings_idx', unique: true
    add_index 'cmor_tags_taggings', %w(taggable_id taggable_type context), name: 'index_taggings_on_taggable_id_and_taggable_type_and_context'
  end
end
