require 'rails_helper'

RSpec.describe '/de/backend/address/addresses', type: :feature do
  let(:resource_class) { Cmor::Addresses::Address }
  let(:resource) { create(:cmor_addresses_address) }
  let(:resources) { create_list(:cmor_addresses_address, 3) }

  let(:role) { create(:cmor_addresses_role) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    role
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_address') {
        select role.name, from: 'address[role_id]'
        fill_in 'address[line1]', with: 'ACME'
      }
      .increasing{ Cmor::Addresses::Address.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_address') {
        fill_in 'address[line1]', with: 'ACME Ltd.'
      }
      .updating
      .from(resource.attributes)
      .to({ "line1" => "ACME Ltd." }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
