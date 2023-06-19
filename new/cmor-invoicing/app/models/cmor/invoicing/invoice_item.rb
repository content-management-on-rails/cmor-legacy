module Cmor::Invoicing
  class InvoiceItem < ApplicationRecord
    belongs_to :invoice

    monetize :price_cents

    validates :title, presence: true
    validates :quantity, presence: true
    validates :price_cents, presence: true
    validates :tax_rate, presence: true
  end
end
