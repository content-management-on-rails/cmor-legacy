FactoryBot.define do
  factory :cmor_cms_page, class: "Cmor::Cms::Page" do
    sequence(:basename) { |i| "page_#{i}" }
    handler { "erb" }
    pathname { "/" }
    title { "Home" }
  end
end
