module Cmor::Invoicing
  class CreateInvoiceService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
    end

    attr_accessor :issuer_name,
      :issuer_street,
      :issuer_postal_code,
      :issuer_city,
      :issuer_country,
      :issuer_tax_number,
      :recipient_name,
      :recipient_street,
      :recipient_postal_code,
      :recipient_city,
      :recipient_country,
      :recipient_tax_number,
      :additional_text,
      :invoice_items

    validates :issuer_name, presence: true
    validates :issuer_street, presence: true
    validates :issuer_postal_code, presence: true
    validates :issuer_city, presence: true
    validates :issuer_country, presence: true
    validates :recipient_name, presence: true
    validates :recipient_street, presence: true
    validates :recipient_postal_code, presence: true
    validates :recipient_city, presence: true
    validates :recipient_country, presence: true
    validates :invoice_items, presence: true

    private

    def _perform
    end
  end
end
