require "rails_helper"

RSpec.describe "/de/backend/links/links", type: :feature do
  let(:resource_class) { Cmor::Links::Link }
  let(:resource) { create(:cmor_links_link) }
  let(:resources) { create_list(:cmor_links_link, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Create
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form("#new_link") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in "link[name]", with: "Google"
        fill_in "link[url]", with: "https://www.google.de"
      }
      .increasing { Cmor::Links::Link.count }.by(1)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_link") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "link[description]", with: "Search Engine"
      }
      .updating
      .from(resource.attributes)
      .to({"description" => "Search Engine"}) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
