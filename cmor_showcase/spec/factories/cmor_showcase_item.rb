FactoryBot.define do
  factory :cmor_showcase_item, class: Cmor::Showcase::Item do
    association(:category, factory: :cmor_showcase_category)
    sequence(:name) { |i| "Item ##{i}" }
  end
end
