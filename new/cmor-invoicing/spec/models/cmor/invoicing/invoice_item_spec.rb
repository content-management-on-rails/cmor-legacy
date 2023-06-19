require "rails_helper"

module Cmor::Invoicing
  RSpec.describe InvoiceItem, type: :model do
    describe "associations" do
      it { expect(subject).to belong_to(:invoice) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:title) }
      it { expect(subject).to validate_presence_of(:quantity) }
      it { expect(subject).to validate_presence_of(:price_cents) }
      it { expect(subject).to validate_presence_of(:tax_rate) }
    end

    describe "price" do
      it { expect(subject).to respond_to(:price) }
    end
  end
end
