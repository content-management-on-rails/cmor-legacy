require "rails_helper"

RSpec.describe Cmor::Blog::Post, type: :model do
  it { expect(described_class).to respond_to(:for_locale) }
  it { expect(subject).to respond_to(:locale) }
  it { expect(subject).to validate_inclusion_of(:locale).in_array(I18n.available_locales.map(&:to_s)) }

  describe "asset_details" do
    describe "#asset_details" do
      let(:asset_detail_assets) {
        [
          {io: File.open(Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])), filename: "example.jpg"},
          {io: File.open(Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])), filename: "example.jpg"}
        ]
      }

      subject { create(:cmor_blog_post) }

      it {
        expect {
          subject.append_asset_detail_assets = asset_detail_assets
          subject.save
        }.to change { Cmor::Blog::AssetDetail.count }.from(0).to(2)
      }
    end

    describe "#appending assets" do
      let(:original_asset_details) { create_list(:cmor_blog_asset_detail, 2, post: subject) }

      let(:new_asset_detail_assets) {
        [
          {io: File.open(Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])), filename: "example.jpg"}
        ]
      }

      subject { create(:cmor_blog_post) }

      before(:each) { original_asset_details }

      it {
        expect {
          subject.append_asset_detail_assets = new_asset_detail_assets
          subject.save
        }.to change { Cmor::Blog::AssetDetail.count }.from(2).to(3)
      }
    end

    describe "#overwriting assets" do
      let(:original_asset_details) { create_list(:cmor_blog_asset_detail, 2, post: subject) }

      let(:new_asset_detail_assets) {
        [
          {io: File.open(Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])), filename: "example.jpg"}
        ]
      }

      subject { create(:cmor_blog_post) }

      before(:each) { original_asset_details }

      it {
        expect {
          subject.overwrite_asset_detail_assets = new_asset_detail_assets
          subject.save
        }.to change { Cmor::Blog::AssetDetail.count }.from(2).to(1)
      }
    end
  end
end
