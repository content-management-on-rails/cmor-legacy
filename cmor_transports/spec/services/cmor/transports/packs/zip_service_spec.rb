# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Transports::Packs::ZipService, type: :model do
  let(:posts) { create_list(:post, 10) }
  let(:exports) { create_list(:cmor_transports_export, 10).map { |e| Cmor::Transports::Exports::CsvService.call!(export: e).export } }
  let(:outgoing) { create(:cmor_transports_outgoing, exports: exports, state: "enqueued_for_pack") }

  before(:each) { posts }

  subject { described_class.new(outgoing: outgoing) }

  describe "changes" do
    it { expect { subject.perform }.to change { outgoing.reload.output.attached? }.from(false).to(true) }
    it { expect { subject.perform }.to change { outgoing.reload.state }.from("enqueued_for_pack").to("succeeded_packing") }
  end

  describe "output" do
    let(:output) { Zip::InputStream.open(StringIO.new(outgoing.output.download)) }
    let(:files) { output.each d }
    before(:each) { subject.perform }

    it do
      exports.each do |e|
        output.get_next_entry
        expect(output.read).to eq(e.output.attachment.download)
      end
      expect(output.eof?).to be_truthy
    end
  end
end
