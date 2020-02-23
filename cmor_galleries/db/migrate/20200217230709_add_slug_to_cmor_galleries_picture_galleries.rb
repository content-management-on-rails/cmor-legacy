class AddSlugToCmorGalleriesPictureGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_galleries_picture_galleries, :slug, :string
  end
end
