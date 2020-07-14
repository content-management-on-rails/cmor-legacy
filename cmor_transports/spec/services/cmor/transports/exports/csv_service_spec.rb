# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Transports::Exports::CsvService, type: :model do
  describe "basic usage" do
    let(:collection) { create_list(:post, 10) }
    let(:resource_class) { Post }
    let(:load_collection_scope) { resource_class }
    let(:export) { create(:cmor_transports_export, root_model: resource_class.name, query: load_collection_scope.all.to_sql) }

    subject { described_class.call!(export: export) }

    before(:each) { collection }

    it { expect(subject).to be_a(Rao::Service::Result::Base) }
    it { expect(subject).to be_ok }
    it { expect(subject.export).to eq(export) }
    it { expect(subject.export.output).to be_attached }

    describe "output" do
      subject { described_class.call!(export: export).export.output }

      it { expect(subject.blob).to be_a(ActiveStorage::Blob) }
      it { expect(subject.blob).to be_a(ActiveStorage::Blob) }
      it { expect(subject.blob.download.lines).to be_a(Array) }
      it { expect(subject.blob.download.lines.size).to eq(collection.size + 1) }
    end
  end
end
