# This migration comes from cmor_cms (originally 5)
class CreateCmorCmsNavigations < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_cms_navigations do |t|
      t.string :locale
      t.string :name

      # friendly id
      t.string :slug

      t.timestamps
    end
  end
end
