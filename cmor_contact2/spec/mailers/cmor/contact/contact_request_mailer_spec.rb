require 'rails_helper'

RSpec.describe Cmor::Contact::ContactRequestMailer, type: :mailer do
  describe "notify" do
    ATTRIBUTES = Cmor::Contact::ContactRequest.attribute_names

    let(:contact_request) { create(:cmor_contact_contact_request, send_notifications: false) }

    let(:sender)       { [contact_request.email] }
    let(:recipients)   { Cmor::Contact::Configuration.recipients[Rails.env] }
    let(:mail_subject) { "[Dummy] New contact request" }

    subject { described_class.notify(contact_request) }

    it { expect(subject.from).to eq(sender) }
    it { expect(subject.to).to eq(recipients) }
    it { expect(subject.subject).to eq(mail_subject) }

    ATTRIBUTES.each do |attribute|
      it { expect(subject.body.encoded).to include(contact_request.class.human_attribute_name(attribute)) }
      it { expect(subject.body.encoded).to include(contact_request.send(attribute).to_s) }
    end
  end
end
