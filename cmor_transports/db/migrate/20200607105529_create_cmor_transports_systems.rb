class CreateCmorTransportsSystems < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_systems do |t|
      t.string :identifier
      t.string :endpoint
      t.string :api_key

      t.timestamps
    end
  end
end
