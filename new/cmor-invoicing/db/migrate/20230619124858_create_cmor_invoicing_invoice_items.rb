class CreateCmorInvoicingInvoiceItems < ActiveRecord::Migration[7.0]
  def change
    create_table :cmor_invoicing_invoice_items do |t|
      t.references :invoice, null: false, foreign_key: {to_table: :cmor_invoicing_invoices}
      t.string :title
      t.text :description
      t.decimal :quantity
      t.decimal :price_cents
      t.decimal :tax_rate

      t.timestamps
    end
  end
end
