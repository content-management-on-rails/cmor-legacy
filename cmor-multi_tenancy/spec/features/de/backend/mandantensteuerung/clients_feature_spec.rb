require "rails_helper"

RSpec.describe "/de/backend/mandantensteuerung/clients", type: :feature do
  let(:resource_class) { Cmor::MultiTenancy::Client }

  describe "REST actions" do
    let(:resource) { create(:cmor_multi_tenancy_client) }
    let(:resources) { create_list(:cmor_multi_tenancy_client, 3) }

    # List
    it {
      resources
      expect(subject).to implement_index_action(self)
    }

    # Create
    it {
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("#new_client") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          fill_in "client[identifier]", with: "acme-gmbh"
          fill_in "client[title]", with: "ACME GmbH"
        }
        .increasing { Cmor::MultiTenancy::Client.count }.by(1)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_client") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     fill_in 'slider[name]', with: 'New name'
          fill_in "client[title]", with: "ACME AG"
        }
        .updating
        .from(resource.attributes)
        .to({"title" => "ACME AG"}) # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end
end
