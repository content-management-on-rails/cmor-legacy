class CreateCmorTransportsOutgoings < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_outgoings do |t|
      t.string :state
      t.references :creator, foreign_key: false, index: true, polymorphic: true
      t.references :job, foreign_key: false, index: true
      t.text :service_messages
      t.text :service_errors
      
      t.timestamps
    end
  end
end
