FactoryBot.define do
  factory :cmor_invoicing_invoice, class: Cmor::Invoicing::Invoice do
    invoice_number { "MyString" }
    issuer_name { "MyString" }
    issuer_street { "MyString" }
    issuer_postal_code { "MyString" }
    issuer_city { "MyString" }
    issuer_country { "MyString" }
    issuer_tax_number { "MyString" }
    recipient_name { "MyString" }
    recipient_street { "MyString" }
    recipient_postal_code { "MyString" }
    recipient_city { "MyString" }
    recipient_country { "MyString" }
  end
end
