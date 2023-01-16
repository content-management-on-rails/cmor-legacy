FactoryBot.define do
  factory :cmor_cms_layout, class: "Cmor::Cms::Layout" do
    sequence(:basename) { |i| "layout_#{i}" }
    handler { "erb" }
    pathname { "/" }
  end
end
