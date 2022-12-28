class AddLocaleToCmorGalleriesPictureGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_galleries_picture_galleries, :locale, :string
  end
end
