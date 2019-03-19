FactoryBot.define do
  factory :cmor_rbac_role, class: Cmor::Rbac::Role do
    sequence(:identifier) { |i| "Permission ##{i}" }
  end
end
