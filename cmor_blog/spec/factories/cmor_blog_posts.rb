FactoryBot.define do
  factory :cmor_blog_post, class: Cmor::Blog::Post do
    association(:creator, factory: :cmor_user_area_user)
    sequence(:title) { |i| "Blog post #{i}"}
    body { 'This is a blog post!' }
  end
end
