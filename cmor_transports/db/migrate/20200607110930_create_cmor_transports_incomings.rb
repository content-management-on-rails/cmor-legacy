class CreateCmorTransportsIncomings < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_incomings do |t|
      t.string :source
      t.references :creator, polymorphic: true
      t.references :job, foreign_key: true
      t.text :service_messages
      t.text :service_errors

      t.timestamps
    end
  end
end
