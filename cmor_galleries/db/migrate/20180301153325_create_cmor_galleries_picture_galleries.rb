class CreateCmorGalleriesPictureGalleries < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_galleries_picture_galleries do |t|
      t.string :name
      t.timestamp :published_at
      t.text :description

      t.timestamps
    end
  end
end
