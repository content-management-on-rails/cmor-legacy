class CreateCmorCmsPartials < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_partials do |t|
      t.string :basename
      t.string :pathname
      t.text :body
      t.string :layout
      t.string :locale
      t.string :format
      t.string :handler

      # associations
      t.references :cmor_cms_folder

      t.timestamps
    end
    add_index :cmor_cms_partials, :cmor_cms_folder_id
  end
end
