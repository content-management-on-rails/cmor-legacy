class CreateCmorShowcaseCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_showcase_categories do |t|
      t.string :locale
      t.string :identifier
      t.string :name
      t.text :body
      t.integer :position
      t.timestamp :published_at
      t.string :slug

      t.timestamps

      t.index :slug, unique: true
    end
  end
end
