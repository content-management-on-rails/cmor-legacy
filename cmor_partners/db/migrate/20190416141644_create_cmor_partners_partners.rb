class CreateCmorPartnersPartners < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_partners_partners do |t|
      t.references :category, foreign_key: false
      t.string :identifier
      t.string :name
      t.text :body
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
