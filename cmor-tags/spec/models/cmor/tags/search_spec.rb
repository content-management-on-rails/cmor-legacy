require "rails_helper"

RSpec.describe Cmor::Tags::Search, type: :model do
  describe "simple search" do
    let(:post) { create(:post) }

    before(:each) do
      post.tag_list.add("foo")
      post.save!
    end

    subject { Cmor::Tags::Search.new(tag_list: "foo").perform }

    it { expect(subject).to be_a(Cmor::Tags::Search::Result) }

    it { expect(subject.found.keys).to include("Post") }
    it { expect(subject.found["Post"].size).to eq(1) }
  end

  context "fuzzy search" do
    let(:post) { create(:post) }

    before(:each) do
      post.tag_list.add("foo")
      post.save!
    end

    subject { Cmor::Tags::Search.new(tag_list: "f", exact: false).perform }

    it { expect(subject).to be_a(Cmor::Tags::Search::Result) }

    it { expect(subject.found.keys).to include("Post") }
    it { expect(subject.found["Post"].size).to eq(1) }
  end
end
