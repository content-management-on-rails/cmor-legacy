class AddTfaStateToCmorUserAreaUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_user_area_users, :tfa_state, :string
  end
end
