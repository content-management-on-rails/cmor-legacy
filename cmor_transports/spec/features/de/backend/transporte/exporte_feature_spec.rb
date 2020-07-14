# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/transporte/exports", type: :feature do
  let(:resource_class) { Cmor::Transports::Export }
  let(:resource) { create(:cmor_transports_export) }
  let(:resources) { create_list(:cmor_transports_export, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_export") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "export[root_model]", with: "Cmor::Cms::Page"
        fill_in "export[query]", with: "SELECT * FROM cmor_cms_pages;"
        fill_in "export[count_query]", with: "SELECT count(*) FROM cmor_cms_pages;"
        select "csv", from: "export[output_format]"
      }
      .increasing { Cmor::Transports::Export.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_export") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        select "yaml", from: "export[output_format]"
      }
      .updating
      .from(resource.attributes)
      .to("output_format" => "yaml") # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
