# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Seo::GenerateMetaTagsService do
  it { expect(described_class.new).to be_a(Cmor::Seo::GenerateMetaTagsService) }

  context "basic usage" do
    let(:resources) { [create_list(:post, 3), create_list(:page, 3)].flatten }
    let(:attributes) { { resources: resources, default_url_options: { protocol: "https", host: "localhost", port: "3000" } } }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    describe "result" do
      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_ok }
      
      describe 'items' do
        it { expect(subject.items.size).to eq(6) }
        it { expect(subject.items.first.title).to eq(resources.first.title) }
      end

      describe 'meta tags' do
        it { expect(subject.meta_tags.map(&:new_record?).uniq).to eq([true]) }
        it { expect(subject.meta_tags.size).to eq(15) }
      end
    end

    describe "autosave" do
      let(:options) { { autosave: true } }

      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_ok }
      it { expect(subject.meta_tags.map(&:persisted?).uniq).to eq([true]) }
    end
  end
end
