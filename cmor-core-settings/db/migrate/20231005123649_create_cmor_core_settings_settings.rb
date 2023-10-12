class CreateCmorCoreSettingsSettings < ActiveRecord::Migration[6.1]
  def change
    create_table :cmor_core_settings_settings do |t|
      t.string :namespace
      t.string :key
      t.string :value

      t.timestamps
    end
  end
end
