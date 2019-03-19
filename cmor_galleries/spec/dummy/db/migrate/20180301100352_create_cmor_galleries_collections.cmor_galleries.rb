# This migration comes from cmor_galleries (originally 20180301094240)
class CreateCmorGalleriesCollections < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_galleries_collections do |t|

      t.timestamps
    end
  end
end
