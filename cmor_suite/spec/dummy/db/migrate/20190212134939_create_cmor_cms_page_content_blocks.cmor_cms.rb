# This migration comes from cmor_cms (originally 8)
class CreateCmorCmsPageContentBlocks < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_page_content_blocks do |t|
      t.text :body

      # associations
      t.references :cmor_cms_page
      t.references :cmor_cms_content_box

      t.timestamps
    end
    add_index :cmor_cms_page_content_blocks, :cmor_cms_page_id
    add_index :cmor_cms_page_content_blocks, :cmor_cms_content_box_id
  end
end
