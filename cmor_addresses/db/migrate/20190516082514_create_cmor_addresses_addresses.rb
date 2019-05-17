class CreateCmorAddressesAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_addresses_addresses do |t|
      t.string :line1
      t.string :line2
      t.string :line3
      t.string :street
      t.string :housenumber
      t.string :zipcode
      t.string :city
      t.string :country
      t.integer :position
      t.references :role
      t.references :addressable, polymorphic: true, index: {name: "index_addressable_id_and_type"}

      t.timestamp
    end
  end
end
