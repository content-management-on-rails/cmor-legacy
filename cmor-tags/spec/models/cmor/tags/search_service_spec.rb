require "rails_helper"

RSpec.describe Cmor::Tags::SearchService, type: :model do
  describe "simple search" do
    let(:post) { create(:post) }

    before(:each) do
      post.tag_list.add("foo")
      post.save!
    end

    subject { Cmor::Tags::SearchService.new(tag_list: "foo").perform }

    it { expect(subject).to be_a(Cmor::Tags::SearchService::Result) }

    it { expect(subject.results.keys).to include("Post") }
    it { expect(subject.results["Post"].size).to eq(1) }
  end

  context "fuzzy search" do
    let(:post) { create(:post) }

    before(:each) do
      post.tag_list.add("foo")
      post.save!
    end

    subject { Cmor::Tags::SearchService.new(tag_list: "f", exact: false).perform }

    it { expect(subject).to be_a(Cmor::Tags::SearchService::Result) }

    it { expect(subject.results.keys).to include("Post") }
    it { expect(subject.results["Post"].size).to eq(1) }
  end
end
