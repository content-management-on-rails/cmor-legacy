class CreateCmorCmsLayouts < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_cms_layouts do |t|
      t.string :basename
      t.string :pathname
      t.text :body
      t.string :locale
      t.string :format
      t.string :handler
      t.timestamp :published_at

      t.timestamps
    end
  end
end
