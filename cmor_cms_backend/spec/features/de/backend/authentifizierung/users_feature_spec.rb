require 'rails_helper'

RSpec.describe '/de/backend/authentifizierung/users', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:resource_class) { Cmor::UserArea::User }
  let(:resource) { create(:cmor_user_area_user) }
  let(:resources) { create_list(:cmor_user_area_user, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_user') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in 'user[email]', with: 'jane.doe@local.domain'
        fill_in 'user[password]', with: 'password'
        fill_in 'user[password_confirmation]', with: 'password'
      }
      .increasing{ Cmor::UserArea::User.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_user') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'user[email]', with: 'john.doe@local.domain'
      }
      .updating
      .from(resource.attributes)
      .to({ 'email' => 'john.doe@local.domain' }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
