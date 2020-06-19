class CreateCmorTransportsExports < ActiveRecord::Migration[5.2]
  def change
    create_table :cmor_transports_exports do |t|
      t.string :root_model
      t.string :query
      t.text :output_attributes, default: [].to_yaml
      t.string :output_format
      t.string :state
      t.text :service_messages
      t.text :service_errors
      t.text :description
      t.references :creator, foreign_key: false, index: true, polymorphic: true
      t.references :job, foreign_key: false, index: true

      t.timestamps
    end
  end
end
