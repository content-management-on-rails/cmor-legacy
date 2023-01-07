class AddOtpBackupCodesToCmorUserAreaUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :cmor_user_area_users, :otp_backup_codes, :text
  end
end
