FactoryBot.define do
  factory :cmor_cms_content_box, class: "Cmor::Cms::ContentBox" do
    sequence(:name) { |i| "Content Box ##{i}" }
  end
end
