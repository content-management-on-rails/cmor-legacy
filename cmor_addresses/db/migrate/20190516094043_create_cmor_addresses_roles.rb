class CreateCmorAddressesRoles < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_addresses_roles do |t|
      t.string :identifier
      t.string :name
      t.integer :position

      t.timestamps
    end
  end
end
