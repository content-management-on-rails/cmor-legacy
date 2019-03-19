# This migration comes from cmor_cms (originally 3)
class CreateCmorCmsTemplates < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_templates do |t|
      t.string :basename
      t.string :pathname
      t.text :body
      t.string :locale
      t.string :format
      t.string :handler

      # associations
      t.references :cmor_cms_folder

      t.timestamps
    end
    add_index :cmor_cms_templates, :cmor_cms_folder_id
  end
end
