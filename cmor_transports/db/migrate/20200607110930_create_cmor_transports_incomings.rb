class CreateCmorTransportsIncomings < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_incomings do |t|
      t.string :uuid, null: :false
      t.string :outgoing_uuid, null: :false
      t.string :state
      t.string :source
      t.references :creator, polymorphic: true
      t.references :job, foreign_key: false, index: true
      t.text :service_messages
      t.text :service_errors

      t.timestamps
    end
  end
end
