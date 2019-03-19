FactoryBot.define do
  factory :cmor_cms_template, class: Cmor::Cms::Template do
    sequence(:basename) { |i| "template_#{i}" }
    handler { 'erb' }
    pathname { '/' }
  end
end
