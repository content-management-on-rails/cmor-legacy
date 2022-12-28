class AddIdentifierToCmorGalleriesPictureGalleries < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_galleries_picture_galleries, :identifier, :string
  end
end
