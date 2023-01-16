FactoryBot.define do
  factory :cmor_cms_navigation_item, class: "Cmor::Cms::NavigationItem" do
    association(:navigation, factory: :cmor_cms_navigation)
    sequence(:name) { |i| "Navigation Item ##{i}" }
    key { name.dasherize }
    url { "/" }

    factory :cmor_cms_navigation_item_root do
      parent { nil }
    end

    factory :cmor_cms_navigation_item_child do
      association :parent, factory: :cmor_cms_navigation_item
    end
  end
end
