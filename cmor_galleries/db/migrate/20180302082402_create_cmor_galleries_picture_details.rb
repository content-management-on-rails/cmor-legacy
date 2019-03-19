class CreateCmorGalleriesPictureDetails < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_galleries_picture_details do |t|
      t.integer :picture_gallery_id
      t.integer :asset_id
      t.string :title
      t.text :description
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
