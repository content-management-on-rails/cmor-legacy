# frozen_string_literal: true

FactoryBot.define do
  factory :cmor_seo_meta_tag, class: Cmor::Seo::MetaTag do
    association(:item, factory: :cmor_seo_item)
    name { "description" }
    content { "This is the meta description." }
  end
end
