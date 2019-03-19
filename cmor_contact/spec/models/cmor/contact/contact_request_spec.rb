require 'rails_helper'

module Cmor::Contact
  RSpec.describe ContactRequest, type: :model do
    it { expect(subject).to validate_presence_of(:name) }
    it { expect(subject).to validate_presence_of(:email) }
    it { expect(subject).to validate_presence_of(:phone) }
    it { expect(subject).to validate_presence_of(:ip_address) }
    it { expect(subject).to validate_presence_of(:message) }

    describe 'spam protection' do
      it { expect(subject).to respond_to(:nickname) }

      describe 'when is spam' do
        subject { build(:cmor_contact_contact_request) }

        before(:each) { subject.nickname = 'Evil Spammer' }

        it { expect(subject).to be_valid }
        it { expect(subject.save).to be_truthy }
        it { subject.valid?; expect(subject.errors.full_messages).to eq([])}
        it { expect{ subject.save }.not_to change{ described_class.count } }
      end

      describe 'when it is not spam' do
        subject { build(:cmor_contact_contact_request) }

        before(:each) { subject.nickname = nil }

        it { expect(subject).to be_valid }
        it { expect(subject.save).to be_truthy }
        it { subject.valid?; expect(subject.errors.full_messages).to eq([])}
        it { expect{ subject.save }.to change{ described_class.count }.from(0).to(1) }
      end
    end

    describe 'notification' do
      let(:contact_request) { build(:cmor_contact_contact_request) }

      before(:each) do
        allow(Cmor::Contact::NotifyNewContactRequestJob).to receive(:perform_later)
        contact_request.save
      end

      it { expect(Cmor::Contact::NotifyNewContactRequestJob).to have_received(:perform_later).once }
    end
  end
end
