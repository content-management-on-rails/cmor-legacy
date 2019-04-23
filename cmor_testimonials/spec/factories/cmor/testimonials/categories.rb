FactoryBot.define do
  factory :cmor_testimonials_category, class: "Cmor::Testimonials::Category" do
    locale { I18n.locale }
    sequence(:identifier) { |i| "category_#{i.to_s}" }
    sequence(:name) { |i| "Category ##{i.to_s}" }
  end
end
