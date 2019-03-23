require 'rails_helper'

RSpec.describe '/de/backend/berechtigungen/permissions', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:resource_class) { Cmor::Rbac::Permission }
  let(:resource) { create(:cmor_rbac_permission) }
  let(:resources) { create_list(:cmor_rbac_permission, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_permission') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in 'permission[identifier]', with: 'delete_users'
      }
      .increasing{ Cmor::Rbac::Permission.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_permission') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'permission[identifier]', with: 'edit_users'
      }
      .updating
      .from(resource.attributes)
      .to({ 'identifier' => 'edit_users' }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
