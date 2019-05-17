FactoryBot.define do
  factory :cmor_addresses_role, class: Cmor::Addresses::Role do
    sequence(:identifier) { |i| "role-#{i}" }
    sequence(:name) { |i| "Role ##{i}" }
  end
end
