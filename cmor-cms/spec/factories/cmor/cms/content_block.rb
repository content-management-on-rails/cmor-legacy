FactoryBot.define do
  factory :cmor_cms_content_block, class: "Cmor::Cms::ContentBlock" do
    association(:content_box, factory: :cmor_cms_content_box)
    association(:page, factory: :cmor_cms_page)
    body { "Content block body" }
  end
end
