class CreateCmorTransportsImports < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_imports do |t|
      t.string :root_model
      t.string :input_format
      t.text :service_messages
      t.text :service_errors
      t.text :description
      t.references :creator, polymorphic: true
      t.references :job, foreign_key: true

      t.timestamps
    end
  end
end
