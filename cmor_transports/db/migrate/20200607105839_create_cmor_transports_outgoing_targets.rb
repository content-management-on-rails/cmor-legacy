class CreateCmorTransportsOutgoingTargets < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_outgoing_targets do |t|
      t.references :outgoing, foreign_key: true
      t.references :system, foreign_key: true

      t.timestamps
    end
  end
end
