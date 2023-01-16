FactoryBot.define do
  factory :cmor_cms_navigation, class: "Cmor::Cms::Navigation" do
    sequence(:name) { |i| "Navigation ##{i}" }
    locale { I18n.locale }
  end
end
