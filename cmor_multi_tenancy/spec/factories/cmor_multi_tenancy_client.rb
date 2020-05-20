FactoryBot.define do
  factory :cmor_multi_tenancy_client, class: Cmor::MultiTenancy::Client do
    sequence(:identifier) { |i| "client-#{i}" }
    sequence(:title) { |i| "Client ##{i}" }
    active_from { Time.at(0) }
    active_to { Time.new(9999, 12, 31, 23, 59, 59) }
  end
end
