# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Seo::GenerateResourceClassesMetaTagsService do
  it { expect(described_class.new).to be_a(Cmor::Seo::GenerateResourceClassesMetaTagsService) }

  context "basic usage" do
    let(:resources) { [create_list(:post, 3), create_list(:page, 3)].flatten }
    let(:attributes) { { resource_classes: [Page, Post] } }
    let(:options) { {} }

    subject { described_class.new(attributes, options) }

    before(:each) { resources }

    describe "result" do
      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_ok }
    end

    describe "autosave" do
      let(:options) { { autosave: true } }

      subject { described_class.call(attributes, options) }

      it { expect(subject).to be_ok }
      it { expect { subject }.to change{ Cmor::Seo::MetaTag.count}.from(0).to(15) }
    end
  end
end
