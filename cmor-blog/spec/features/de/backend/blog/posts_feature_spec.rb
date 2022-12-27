require "rails_helper"

RSpec.describe "/de/backend/blog/posts", type: :feature do
  let(:resource_class) { Cmor::Blog::Post }

  describe "REST actions" do
    let(:resource) { create(:cmor_blog_post) }
    let(:resources) { create_list(:cmor_blog_post, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    it {
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("#new_post") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          fill_in "post[title]", with: "My first blog post"
          fill_in "post[body]", with: "Lorem Ipsum."
          attach_file("post[append_asset_detail_assets][]", File.absolute_path(Cmor::Blog::Engine.root.join("spec", "files", "cmor", "blog", "post", "asset", "example.jpg")))
        }
        .increasing { Cmor::Blog::Post.count }.by(1)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_post") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     fill_in 'slider[name]', with: 'New name'
          fill_in "post[body]", with: "Blah blah blah."
        }
        .updating
        .from(resource.attributes)
        .to({"body" => "Blah blah blah."}) # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end

  describe "appending asset details" do
    let(:original_asset_details) { create_list(:cmor_blog_asset_detail, 2, post: resource) }
    let(:resource) { create(:cmor_blog_post) }
    let(:base_path) { "/de/backend/blog/posts" }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within("form.edit_post") { first('input[type="submit"]') } }

    before(:each) do
      original_asset_details
      visit(edit_path)
      attach_file "post[append_asset_detail_assets][]", [Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])]
    end

    it { expect { submit_button.click }.to change { resource.asset_details.count }.from(2).to(3) }
  end

  describe "replacing asset details" do
    let(:original_asset_details) { create_list(:cmor_blog_asset_detail, 2, post: resource) }
    let(:resource) { create(:cmor_blog_post) }
    let(:base_path) { "/de/backend/blog/posts" }
    let(:edit_path) { "#{base_path}/#{resource.to_param}/edit" }

    let(:submit_button) { within("form.edit_post") { first('input[type="submit"]') } }

    before(:each) do
      original_asset_details
      visit(edit_path)
      attach_file "post[overwrite_asset_detail_assets][]", [Cmor::Blog::Engine.root.join(*%w[spec files cmor blog post asset example.jpg])]
    end

    it { expect { submit_button.click }.to change { resource.asset_details.count }.from(2).to(1) }
  end
end
