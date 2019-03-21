require 'rails_helper'

RSpec.describe Cmor::Contact::NotifyNewContactRequestJob, type: :job do
  let(:contact_request) { create(:cmor_contact_contact_request)}

  describe '#perform' do
    before(:each) do
      allow(Cmor::Contact::ContactRequestMailer).to receive_message_chain(:notify, :deliver_now)
      described_class.new.perform(contact_request.id)
    end

    it { expect(Cmor::Contact::ContactRequestMailer).to have_received(:notify) }
    it { contact_request.reload; expect(contact_request.notified_at).to be_a(Time) }
  end

  describe '.perform_later' do
    before(:each) { described_class.perform_later(contact_request.id) }

    it { expect(enqueued_jobs.size).to eq(1) }
    it { expect(enqueued_jobs.last[:job]).to eq(described_class) }
  end
end