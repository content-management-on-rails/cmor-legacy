FactoryBot.define do
  factory :cmor_links_link, class: Cmor::Links::Link do
    sequence(:name) { |i| "Link #{i}" }
    sequence(:url)  { |i| "http://www.example.com/#{i}" }
  end
end
