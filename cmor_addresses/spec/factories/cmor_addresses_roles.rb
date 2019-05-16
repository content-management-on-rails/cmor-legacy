FactoryBot.define do
  factory :cmor_partners_role, class: Cmor::Addresses::Role do
    sequence(:identifier) { |i| "category-#{i}" }
    sequence(:name) { |i| "Category ##{i}" }
  end
end
