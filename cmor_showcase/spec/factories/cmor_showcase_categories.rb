FactoryBot.define do
  factory :cmor_showcase_category, class: Cmor::Showcase::Category do
    locale { I18n.locale }
    sequence(:identifier) { |i| "category-#{i}" }
    sequence(:name) { |i| "Category ##{i}" }
  end
end
