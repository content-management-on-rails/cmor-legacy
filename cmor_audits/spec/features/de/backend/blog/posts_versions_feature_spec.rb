# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/blog/posts/:id/versions", type: :feature do
  let(:resource_class) { Cmor::Blog::Post }
  let(:factory_name) { :cmor_blog_post }
  let(:resource) { create(factory_name) }
  let(:base_path) { "/de/backend/blog/posts/#{resource.to_param}" }
  let(:versions_path) { [base_path, "versions"].join("/") }

  describe "actions" do
    describe "versions/:version_id" do
      let(:version) { resource.versions.last }
      let(:version_path) { [versions_path, version.to_param].join("/") }

      before(:each) do
        resource.title = "Updated title"
        resource.save
        visit(version_path)
      end

      it { expect(current_path).to eq(version_path) }
      it { expect(page.status_code).to eq(200) }
    end

    describe "version_at" do
      let(:version_at_path) { [base_path, "version_at"].join("/") }

      before(:each) do
        visit(version_at_path)
      end

      it { expect(current_path).to eq(version_at_path) }
      it { expect(page.status_code).to eq(200) }
    end

    describe "version_at/:version_at" do
      let(:timestamp) { ERB::Util.url_encode(Time.zone.now) }
      let(:version_at_path) { [base_path, "version_at", timestamp].join("/") }

      before(:each) do
        visit(version_at_path)
      end

      it { expect(current_path).to eq(version_at_path) }
      it { expect(page.status_code).to eq(200) }
    end

    describe "versions" do
      before(:each) do
        visit(versions_path)
      end

      it { expect(current_path).to eq(versions_path) }
      it { expect(page.status_code).to eq(200) }
    end
  end
end
