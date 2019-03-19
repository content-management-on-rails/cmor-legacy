FactoryBot.define do
  factory :cmor_rbac_permission, class: Cmor::Rbac::Permission do
    sequence(:identifier) { |i| "Permission ##{i}" }
  end
end
