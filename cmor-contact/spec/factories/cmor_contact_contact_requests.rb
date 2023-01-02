FactoryBot.define do
  factory :cmor_contact_contact_request, class: "Cmor::Contact::ContactRequest" do
    name { "John Doe" }
    email { "john.doe@example.com" }
    phone { "+491234567890" } if Cmor::Contact::Configuration.contact_request_include_modules.call.include?(Cmor::Contact::ContactRequest::PhoneConcern)
    subject { "I need help!" } if Cmor::Contact::Configuration.contact_request_include_modules.call.include?(Cmor::Contact::ContactRequest::SubjectConcern)
    ip_address { "127.0.0.1" }
    message { "Please callback!" }
    accept_terms_of_service { true }
  end
end
