FactoryBot.define do
  factory :cmor_contact_contact_request, class: 'Cmor::Contact::ContactRequest' do
    name { "John Doe" }
    email { "john.doe@example.com" }
    phone { "+491234567890" }
    ip_address { "127.0.0.1" }
    message { "Please callback!" }
    accept_terms_of_service { true }
  end
end
