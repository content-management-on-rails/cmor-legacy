class CreateCmorCarouselsCarousels < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_carousels_carousels do |t|
      t.string :locale      
      t.string :identifier
      t.string :variant_options

      t.timestamps
    end
  end
end
