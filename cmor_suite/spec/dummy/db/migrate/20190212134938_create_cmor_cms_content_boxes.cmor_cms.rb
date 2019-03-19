# This migration comes from cmor_cms (originally 7)
class CreateCmorCmsContentBoxes < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_content_boxes do |t|
      t.string :name

      t.timestamps
    end
  end
end
