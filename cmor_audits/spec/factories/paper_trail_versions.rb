FactoryBot.define do
  factory :paper_trail_version, class: ::PaperTrail::Version do
    event { 'create' }
    association(:item, factory: :cmor_blog_post)
  end
end
