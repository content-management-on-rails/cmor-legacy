require "rails_helper"

RSpec.describe Cmor::Invoicing::GenerateInvoicePdfService, type: :service do
  describe "basic usage" do
    let(:invoice) { create(:cmor_invoicing_invoice) }
    let(:attributes) do
      {invoice: invoice}
    end

    let(:options) do
      {}
    end

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { described_class.new(attributes, options).perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
      it { expect(subject).to be_ok }
      it { expect(subject.errors.full_messages).to eq([]) }

      describe "#pdf" do
        subject { described_class.new(attributes, options).perform.pdf }

        it { expect(subject).to be_a(String) }
      end
    end
  end
end
