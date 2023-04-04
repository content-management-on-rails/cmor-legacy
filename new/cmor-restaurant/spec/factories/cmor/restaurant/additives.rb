FactoryBot.define do
  factory :cmor_restaurant_additive, class: Cmor::Restaurant::Additive do
    sequence(:name) { |n| "Additive ##{n}" }
    sequence(:identifier) { |n| "additive_#{n}" }
  end
end
