FactoryBot.define do
  factory :cmor_testimonials_testimonial, class: "Cmor::Testimonials::Testimonial" do
    association(:category, factory: :cmor_testimonials_category)
    sequence(:full_name) {|n| "John_Doe_#{n}" }
    role { "MyString" }
    company { "MyString" }
    body { "MyText" }
    published_at { 1.hour.ago }
    after(:build) do |resource|
      image = resource.image.attach(
        io:           File.open(Cmor::Testimonials::Engine.root.join(*%w( spec files cmor testimonials testimonials homer.png))),
        filename:     'homer.png',
        content_type: 'image/png'
      )
    end
  end
end
