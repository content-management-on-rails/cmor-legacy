class CreateCmorCmsContentBlocks < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_content_blocks do |t|
      t.text :body

      # associations
      t.references :page
      t.references :content_box

      t.timestamps
    end
    add_index :cmor_cms_content_blocks, :page_id
    add_index :cmor_cms_content_blocks, :content_box_id
  end
end
