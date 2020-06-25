class CreateCmorTransportsOutgoingExports < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_outgoing_exports do |t|
      t.references :outgoing, foreign_key: false, index: true
      t.references :export, foreign_key: false, index: true

      t.timestamps
    end
  end
end
