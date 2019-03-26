class CreateCmorCmsTemplates < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_templates do |t|
      t.string :basename
      t.string :pathname
      t.text :body
      t.string :locale
      t.string :format
      t.string :handler

      t.timestamps
    end
  end
end
