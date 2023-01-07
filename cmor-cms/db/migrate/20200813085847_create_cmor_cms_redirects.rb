class CreateCmorCmsRedirects < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_cms_redirects do |t|
      t.text :source
      t.text :target
      t.integer :position
      t.timestamp :published_at

      t.timestamps
    end
  end
end
