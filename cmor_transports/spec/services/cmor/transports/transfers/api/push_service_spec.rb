require 'rails_helper'

RSpec.describe Cmor::Transports::Transfers::Api::PushService, type: :model, vcr: true do
  let(:posts) { create_list(:post, 10) }
  let(:exports) { create_list(:cmor_transports_export, 10).map { |e| Cmor::Transports::Exports::CsvService.call!(export: e).export } }
  let(:systems) { create_list(:cmor_transports_system, 1, endpoint: 'http://localhost:3001/de/backend/transporte/api/') }
  let(:outgoing) { create(:cmor_transports_outgoing, systems: systems, exports: exports) }

  before(:each) do
    posts
    outgoing.enqueue_packing!
    Timeout::timeout(5) do
      begin
      end until outgoing.reload.succeeded_packing? or not sleep(0.1)
    end
    outgoing.update_attribute(:state, 'enqueued_for_transfer')
  end

  subject { described_class.new(outgoing: outgoing) }
  
  describe 'changes' do
    # it { expect { subject.perform }.to change { Cmor::Transports::Incoming.count }.from(0).to(1) }
    it { expect { subject.perform }.to change { outgoing.reload.state }.from('enqueued_for_transfer').to('succeeded_transferring') }
  end

  describe 'result' do
    subject { described_class.call(outgoing: outgoing) }

    it { expect(subject).to be_ok }
    it { expect(subject.errors.full_messages).to eq([]) }
  end
end
