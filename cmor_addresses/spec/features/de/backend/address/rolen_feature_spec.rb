require 'rails_helper'

RSpec.describe '/de/backend/address/roles', type: :feature do
  let(:resource_class) { Cmor::Addresses::Role }
  let(:resource) { create(:cmor_addresses_role) }
  let(:resources) { create_list(:cmor_addresses_role, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_role') {
        fill_in 'role[identifier]', with: 'role-1'
        fill_in 'role[name]', with: 'Invoice'
      }
      .increasing{ Cmor::Addresses::Role.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_role') {
        fill_in 'role[name]', with: 'Order'
      }
      .updating
      .from(resource.attributes)
      .to({ 'name' => 'Order' }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
