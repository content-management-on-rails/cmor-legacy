class CreateCmorInvoicingInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_invoicing_invoices do |t|
      t.string :invoice_number
      t.string :issuer_name
      t.string :issuer_street
      t.string :issuer_postal_code
      t.string :issuer_city
      t.string :issuer_country
      t.string :issuer_tax_number
      t.string :recipient_name
      t.string :recipient_street
      t.string :recipient_postal_code
      t.string :recipient_city
      t.string :recipient_country
      t.string :recipient_tax_number

      t.timestamps
    end
  end
end
