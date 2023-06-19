module Cmor::Invoicing
  class GenerateInvoicePdfService < Rao::Service::Base
    class Result < Rao::Service::Result::Base
      attr_accessor :pdf
    end

    attr_accessor :invoice

    validates :invoice, presence: true

    private

    def _perform
      @result.pdf = generate_pdf!
    end

    def generate_pdf!
      WickedPdf.new.pdf_from_string(render_view!)
    end

    def render_view!
      ApplicationController.render(
        template: "cmor/invoicing/generate_invoice_pdf_service/generate_pdf",
        layout: "cmor/invoicing/invoices/pdf",
        assigns: {invoice: invoice}
      )
    end
  end
end
