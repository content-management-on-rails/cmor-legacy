# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/seo/meta_tags", type: :feature do
  let(:resource_class) { Cmor::Seo::MetaTag }
  let(:resource) { create(:cmor_seo_meta_tag) }
  let(:resources) { create_list(:cmor_seo_meta_tag, 3) }

  let(:item) { create(:cmor_seo_item) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    item
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_meta_tag") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select item.human, from: "meta_tag[item_id]"
        fill_in "meta_tag[name]", with: "description"
        fill_in "meta_tag[content]", with: "This is the meta description"
      }
      .increasing { Cmor::Seo::MetaTag.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_meta_tag") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "meta_tag[content]", with: "This is the new meta description"
      }
      .updating
      .from(resource.attributes)
      .to("content" => "This is the new meta description") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
