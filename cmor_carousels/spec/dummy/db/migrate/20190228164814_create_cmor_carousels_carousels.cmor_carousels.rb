# This migration comes from cmor_carousels (originally 1)
class CreateCmorCarouselsCarousels < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_carousels_carousels do |t|
      t.string :locale      
      t.string :identifier

      t.timestamps
    end
  end
end
