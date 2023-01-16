class CreateCmorPartnersCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_partners_categories do |t|
      t.string :locale
      t.string :identifier
      t.string :name
      t.text :body
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
