FactoryBot.define do
  factory :cmor_testimonials_category, class: "Cmor::Testimonials::Category" do
    sequence(:identifier) { |i| "category_#{i.to_s}" }
  end
end
