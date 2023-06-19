require "rails_helper"

RSpec.describe Cmor::Invoicing::CreateInvoiceService, type: :service do
  describe "basic usage" do
    let(:attributes) do
      {}
    end

    let(:options) do
      {}
    end

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { described_class.new(attributes, options).perform }

      it { expect(subject).to be_a(Rao::Service::Result::Base) }
    end
  end
end
