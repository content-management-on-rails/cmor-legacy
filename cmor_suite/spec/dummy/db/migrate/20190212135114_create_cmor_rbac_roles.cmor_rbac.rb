# This migration comes from cmor_rbac (originally 20160301103116)
class CreateCmorRbacRoles < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_rbac_roles do |t|
      t.string :identifier
      t.timestamp :enabled_from
      t.timestamp :enabled_to

      t.timestamps null: false
    end
  end
end
