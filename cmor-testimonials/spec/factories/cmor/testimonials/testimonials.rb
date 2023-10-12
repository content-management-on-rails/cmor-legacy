FactoryBot.define do
  factory :cmor_testimonials_testimonial, class: "Cmor::Testimonials::Testimonial" do
    association(:category, factory: :cmor_testimonials_category)
    sequence(:fullname) { |n| "John_Doe_#{n}" }
    role { "MyString" }
    company { "MyString" }
    body { "MyText" }
    published { true }
    after(:build) do |resource|
      resource.image.attach(
        io: File.open(Cmor::Testimonials::Engine.root.join(*%w[spec files cmor testimonials testimonials homer.png])),
        filename: "homer.png",
        content_type: "image/png"
      )
    end
  end
end
