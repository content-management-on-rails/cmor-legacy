# This migration comes from cmor_sliders (originally 1)
class CreateCmorSlidersSliders < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_sliders_sliders do |t|
      t.string :locale
      t.string :name
      t.text :description
      t.boolean :auto_start
      t.decimal :interval, :precision => 8, :scale => 2
      t.string :slug

      t.timestamps
    end
  end
end
