class CreateCmorCmsPages < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_pages do |t|
      t.string :basename
      t.string :pathname
      t.string :title
      t.text :meta_description
      t.text :body
      t.string :layout
      t.string :locale
      t.string :format
      t.string :handler

      t.timestamps
    end
  end
end
