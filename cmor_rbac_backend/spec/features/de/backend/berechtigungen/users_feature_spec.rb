require 'rails_helper'

RSpec.describe '/de/backend/berechtigungen/users', type: :feature do
  let(:role) { create(:cmor_rbac_role)}

  let(:resource_class) { Cmor::UserArea::User }
  let(:resource) { create(:cmor_user_area_user) }
  let(:resources) { create_list(:cmor_user_area_user, 3) }

  it { resources; expect(subject).to implement_index_action(self) }
  
  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    role
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_user') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        check role.identifier
      }
      .updating{ |resource| resource.roles.to_a }
      .from([])
      .to([role])
  }
end
