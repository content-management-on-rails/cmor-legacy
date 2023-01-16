FactoryBot.define do
  factory :cmor_cms_partial, class: "Cmor::Cms::Partial" do
    sequence(:basename) { |i| "_partial_#{i}" }
    handler { "erb" }
    pathname { "/" }
  end
end
