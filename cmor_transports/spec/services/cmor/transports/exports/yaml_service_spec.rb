require 'rails_helper'

RSpec.describe Cmor::Transports::Exports::YamlService, type: :model do
  describe 'basic usage' do
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

    describe 'output' do
      subject { described_class.call!(export: export).export.output }

      it { expect(subject.blob).to be_a(ActiveStorage::Blob) }
      it { expect(subject.blob).to be_a(ActiveStorage::Blob) }
      it { expect(YAML.load(subject.blob.download)).to be_a(Array) }
      it { expect(YAML.load(subject.blob.download).size).to eq(collection.size) }
    end
  end
end