FactoryBot.define do
  factory :cmor_cms_redirect, class: 'Cmor::Cms::Redirect' do
    source { "/source" }
    target { "/target" }
  end
end
