class CreateCmorMultiTenancyClients < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_multi_tenancy_clients do |t|
      t.string :identifier
      t.string :title
      t.text :description
      t.string :position
      t.timestamp :active_from
      t.timestamp :active_to
      t.boolean :default, default: false

      t.timestamps
    end
  end
end
