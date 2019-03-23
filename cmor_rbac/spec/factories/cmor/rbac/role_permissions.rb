FactoryBot.define do
  factory :cmor_rbac_role_permission, class: Cmor::Rbac::RolePermission do
    association(:role,       factory: :cmor_rbac_role)
    association(:permission, factory: :cmor_rbac_permission)
  end
end
