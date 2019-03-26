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

      t.timestamps
    end
  end
end
