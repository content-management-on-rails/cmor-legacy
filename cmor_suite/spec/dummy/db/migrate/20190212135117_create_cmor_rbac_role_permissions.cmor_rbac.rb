# This migration comes from cmor_rbac (originally 20160301103240)
class CreateCmorRbacRolePermissions < ActiveRecord::Migration[4.2]
  def change
    create_table :cmor_rbac_role_permissions do |t|
      t.integer :role_id, index: true
      t.integer :permission_id, index: true

      t.timestamps null: false
    end
  end
end
