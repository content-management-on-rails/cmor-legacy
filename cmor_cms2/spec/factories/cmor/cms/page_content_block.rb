FactoryBot.define do
  factory :cmor_cms_page_content_block, class: Cmor::Cms::Page::ContentBlock do
    body { 'Content block body' }
    cmor_cms_content_box
    cmor_cms_page
  end
end
