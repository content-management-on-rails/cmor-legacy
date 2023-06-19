require "rails_helper"

module Cmor::Invoicing
  RSpec.describe Invoice, type: :model do
    describe "associations" do
      it { expect(subject).to have_many(:invoice_items).dependent(:destroy) }
      it { expect(subject).to have_one_attached(:logo) }
      it { expect(subject).to have_one_attached(:rendered_pdf) }
    end

    describe "validations" do
      it { expect(subject).to validate_presence_of(:invoice_number) }
      it { expect(subject).to validate_presence_of(:issuer_name) }
      it { expect(subject).to validate_presence_of(:issuer_street) }
      it { expect(subject).to validate_presence_of(:issuer_postal_code) }
      it { expect(subject).to validate_presence_of(:issuer_city) }
      it { expect(subject).to validate_presence_of(:issuer_country) }
      it { expect(subject).to validate_presence_of(:recipient_name) }
      it { expect(subject).to validate_presence_of(:recipient_street) }
      it { expect(subject).to validate_presence_of(:recipient_postal_code) }
      it { expect(subject).to validate_presence_of(:recipient_city) }
      it { expect(subject).to validate_presence_of(:recipient_country) }
    end
  end
end
