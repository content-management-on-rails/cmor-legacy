class AddPositionToCmorGalleriesPictureGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_galleries_picture_galleries, :position, :integer
  end
end
