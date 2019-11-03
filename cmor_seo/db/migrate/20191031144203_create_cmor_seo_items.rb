class CreateCmorSeoItems < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_seo_items do |t|
      t.references :resource, polymorphic: true
      t.string :path
      t.timestamp :published_at

      t.timestamps
    end
  end
end
