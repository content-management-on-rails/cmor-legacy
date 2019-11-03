class CreateCmorSeoMetaTags < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_seo_meta_tags do |t|
      t.references :item, foreign_key: false
      t.integer :position
      t.timestamp :published_at
      t.string :name
      t.text :content

      t.timestamps
    end
  end
end
