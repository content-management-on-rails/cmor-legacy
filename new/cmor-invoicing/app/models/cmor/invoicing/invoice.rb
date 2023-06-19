module Cmor::Invoicing
  class Invoice < ApplicationRecord
    has_many :invoice_items, dependent: :destroy, inverse_of: :invoice

    has_one_attached :logo
    has_one_attached :rendered_pdf

    validates :invoice_number, presence: true
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
  end
end
