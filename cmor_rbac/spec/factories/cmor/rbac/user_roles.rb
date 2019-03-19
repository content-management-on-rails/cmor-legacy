FactoryBot.define do
  factory :cmor_rbac_user_role, class: Cmor::Rbac::UserRole do
    association :user, factory: Cmor::Rbac::Configuration.user_class_name.underscore.gsub('/', '_')
    association :role, factory: :cmor_rbac_role
  end
end
