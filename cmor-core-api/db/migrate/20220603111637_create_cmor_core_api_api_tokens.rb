class CreateCmorCoreApiApiTokens < ActiveRecord::Migration[6.0]
  def change
    create_table :cmor_core_api_api_tokens do |t|
      t.string :token, null: false
      t.string :description
      t.boolean :can_write, default: false
      t.timestamp :active_from, null: false
      t.timestamp :active_to, null: false

      t.timestamps
    end
  end
end
