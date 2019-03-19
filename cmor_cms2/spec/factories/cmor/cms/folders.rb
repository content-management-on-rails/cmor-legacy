FactoryBot.define do
  factory :cmor_cms_folder, class: Cmor::Cms::Folder do
    pathname { '/' }
    basename { 'foo' }
  end
end
