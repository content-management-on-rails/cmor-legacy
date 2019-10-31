class CreateCmorSeoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_seo_items do |t|
      t.references :resorce, foreign_key: true
      t.timestamp :published_at

      t.timestamps
    end
  end
end
