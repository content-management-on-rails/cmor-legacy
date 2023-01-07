class AddOtpSecretKeyToCmorUserAreaUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_user_area_users, :otp_secret_key, :string
  end
end
