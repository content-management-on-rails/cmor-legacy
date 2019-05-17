FactoryBot.define do
  factory :cmor_addresses_address, class: Cmor::Addresses::Address do
    association :role, factory: :cmor_addresses_role
  end
end
