FactoryBot.define do
  factory :cmor_testimonials_testimonial, class: "Cmor::Testimonials::Testimonial" do
    association(:category, factory: :cmor_testimonials_category)
    full_name { "MyString" }
    role { "MyString" }
    company { "MyString" }
    body { "MyText" }
    published_at { 1.hour.ago }
  end
end
