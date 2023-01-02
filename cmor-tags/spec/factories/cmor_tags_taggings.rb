FactoryBot.define do
  factory :cmor_tags_tagging, class: Cmor::Tags::Tagging do
    association :taggable, factory: Cmor::Tags::Configuration.taggable_factory_name
    association :tag, factory: :cmor_tags_tag, strategy: :create
    context { "tags" }
  end
end
