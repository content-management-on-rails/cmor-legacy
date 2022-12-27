FactoryBot.define do
  factory :cmor_blog_post, class: Cmor::Blog::Post do
    association(:creator, factory: Cmor::Blog::Configuration.user_factory_name)
    sequence(:title) { |i| "Blog post #{i}" }
    body { "This is a blog post!" }
  end
end
