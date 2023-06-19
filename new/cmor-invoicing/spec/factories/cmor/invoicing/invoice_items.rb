FactoryBot.define do
  factory :cmor_invoicing_invoice_item, class: Cmor::Invoicing::InvoiceItem do
    association(:invoice, factory: :cmor_invoicing_invoice)
    title { "MyString" }
    quantity { 1 }
    price_cents { 4200 }
    tax_rate { 19 }
  end
end
