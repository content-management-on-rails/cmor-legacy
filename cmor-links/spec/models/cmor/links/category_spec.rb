require "rails_helper"

RSpec.describe Cmor::Links::Category, type: :model do
  it { expect(subject).to respond_to(:human) }
  it { expect(subject).to have_many(:links) }
  it { expect(subject).to validate_presence_of(:name) }
  it { expect(subject).to validate_uniqueness_of(:name).scoped_to(:parent_id) }

  context "acts as markup" do
    subject do
      create(:cmor_links_category,
        short_description: "# This is a heading",
        long_description: "# This is a heading")
    end

    context "short_description.to_html" do
      it { expect(subject.short_description(:html)).to eq("<h1 id=\"this-is-a-heading\">This is a heading</h1>\n") }
    end

    context "long_description.to_html" do
      it { expect(subject.long_description(:html)).to eq("<h1 id=\"this-is-a-heading\">This is a heading</h1>\n") }
    end
  end

  context "acts as tree" do
    describe "root node" do
      subject { create(:cmor_links_category) }

      it { expect(subject).to respond_to(:root) }

      it "should require a locale if it is a root node" do
        subject.locale = nil
        expect(subject).not_to be_valid
      end
    end

    describe "child node" do
      subject { build(:cmor_links_category_with_parent, locale: "en") }
      it { expect(subject).not_to be_valid }
    end
  end

  context "friendly id" do
    subject { create(:cmor_links_category, name: "Look, a slugged category!") }

    it { expect(subject.to_param).to eq("look-a-slugged-category") }
  end
end
