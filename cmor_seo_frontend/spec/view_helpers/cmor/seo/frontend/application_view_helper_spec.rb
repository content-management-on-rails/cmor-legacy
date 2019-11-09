# frozen_string_literal: true

require "rails_helper"

RSpec.describe Cmor::Seo::Frontend::ApplicationViewHelper, type: :view_helper do
  let(:request) { ActionDispatch::Request.new({ "SCRIPT_NAME" => "", "PATH_INFO" => "/" }) }

  before(:each) do
    view.request = request
  end

  context "when having no meta tags" do
    describe "render_meta_tags" do
      it { expect(rendered).to eq(nil) }
    end
  end

  context "when having meta tags for a path" do
    let(:item) { create(:cmor_seo_item, path: "/", published: true) }
    let(:meta_tag) { create(:cmor_seo_meta_tag, item: item, published: true) }

    before(:each) { meta_tag }

    describe "render_meta_tags" do
      it { expect(rendered).to eq("<meta name=\"#{meta_tag.name}\" content=\"#{meta_tag.content}\" />\n") }
    end
  end

  context "when having meta tags for a resource" do
    let(:post) { create(:post) }
    let(:item) { create(:cmor_seo_item, resource: post, path: nil, published: true) }
    let(:meta_tag) { create(:cmor_seo_meta_tag, item: item, published: true) }

    before(:each) do
      meta_tag
      view.instance_variable_set(:@resource, item.resource)
      view.define_singleton_method(:resource_class) do
        item.resource.class
      end
    end

    describe "render_meta_tags" do
      it { expect(rendered).to eq("<meta name=\"#{meta_tag.name}\" content=\"#{meta_tag.content}\" />\n") }
    end
  end
end
