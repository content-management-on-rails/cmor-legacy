class AddIdentifierToCmorGalleriesPictureDetails < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_galleries_picture_details, :identifier, :string
  end
end
