FactoryBot.define do
  factory :cmor_rbac_user_role, class: Cmor::Rbac::UserRole do
    association(:user, factory: Cmor::Rbac::Configuration.user_factory_name)
    association(:role, factory: :cmor_rbac_role)
  end
end
