FactoryBot.define do
  factory :cmor_tags_tagging, class: Cmor::Tags::Tagging do
    association :tag, factory: :cmor_tags_tag, strategy: :create
    context { 'tags' }
  end
end
