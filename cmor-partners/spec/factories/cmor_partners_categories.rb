FactoryBot.define do
  factory :cmor_partners_category, class: Cmor::Partners::Category do
    locale { I18n.locale }
    sequence(:identifier) { |i| "category-#{i}" }
    sequence(:name) { |i| "Category ##{i}" }
  end
end
