class CreateCmorUserAreaUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_user_area_users do |t|
      # Authlogic::ActsAsAuthentic::Email
      t.string :email

      # Authlogic::ActsAsAuthentic::Password
      t.string :crypted_password
      t.string :password_salt

      # Authlogic::ActsAsAuthentic::PersistenceToken
      t.string :persistence_token

      # Authlogic::ActsAsAuthentic::SingleAccessToken
      t.string :single_access_token

      # Authlogic::ActsAsAuthentic::PerishableToken
      t.string :perishable_token

      # Authlogic::Session::MagicColumns
      t.integer :login_count, default: 0, null: false
      t.integer :failed_login_count, default: 0, null: false
      t.datetime :last_request_at
      t.datetime :current_login_at
      t.datetime :last_login_at
      t.string :current_login_ip
      t.string :last_login_ip

      # Authlogic::Session::MagicStates
      t.boolean :active, default: false
      t.boolean :approved, default: false
      t.boolean :confirmed, default: false

      t.timestamps null: false
    end
  end
end
