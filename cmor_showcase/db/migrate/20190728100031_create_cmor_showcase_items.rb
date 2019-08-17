class CreateCmorShowcaseItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_showcase_items do |t|
      t.references :category, foreign_key: false
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
