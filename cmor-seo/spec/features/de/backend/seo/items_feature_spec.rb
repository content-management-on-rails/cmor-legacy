# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/seo/items", type: :feature do
  let(:resource_class) { Cmor::Seo::Item }
  let(:resource) { create(:cmor_seo_item) }
  let(:resources) { create_list(:cmor_seo_item, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_item") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "item[path]", with: "/de"
      }
      .increasing { Cmor::Seo::Item.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_item") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "item[path]", with: "/de/foo"
      }
      .updating
      .from(resource.attributes)
      .to("path" => "/de/foo") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
