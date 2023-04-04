FactoryBot.define do
  factory :cmor_restaurant_category, class: Cmor::Restaurant::Category do
    sequence(:identifier) { |n| "identifier_#{n}" }
    sequence(:name) { |n| "Category ##{n}" }
  end
end
