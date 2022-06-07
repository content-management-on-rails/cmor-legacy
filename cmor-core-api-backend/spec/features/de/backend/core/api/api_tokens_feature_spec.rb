# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/core/api/tokens", type: :feature do
  let(:resource_class) { Cmor::Core::Api::ApiToken }
  let(:resource) { create(:cmor_core_api_api_token) }
  let(:resources) { create_list(:cmor_core_api_api_token, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_api_token") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "token[active_from]", with: Time.zone.now
        fill_in "token[active_to]", with: 1.year.from_now
      }
      .increasing { resource_class.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_api_token") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        check "token[can_write]"
      }
      .updating
      .from(resource.attributes)
      .to("can_write" => true) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
