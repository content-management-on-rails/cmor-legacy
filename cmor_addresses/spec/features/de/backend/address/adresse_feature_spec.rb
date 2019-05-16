# require 'rails_helper'

# RSpec.describe '/de/backend/address/addresses', type: :feature do
#   let(:resource_class) { Cmor::Addresses::Partner }
#   let(:resource) { create(:cmor_partners_partner) }
#   let(:resources) { create_list(:cmor_partners_partner, 3) }

#   let(:category) { create(:cmor_partners_category) }

#   # List
#   it { resources; expect(subject).to implement_index_action(self) }

#   # Create
#   it { 
#     category
#     expect(subject).to implement_create_action(self)
#       .for(resource_class)
#       .within_form('#new_partner') {
#         # fill the needed form inputs via capybara here
#         #
#         # Example:
#         #
#         #     select 'de', from: 'slider[locale]'
#         #     fill_in 'slider[name]', with: 'My first slider'
#         #     check 'slider[auto_start]'
#         #     fill_in 'slider[interval]', with: '3'
#         select category.name, from: 'address[category_id]'
#         fill_in 'address[name]', with: 'ACME'
#       }
#       .increasing{ Cmor::Addresses::Partner.count }.by(1)
#   }
  
#   # Read
#   it { expect(subject).to implement_show_action(self).for(resource) }

#   # Update
#   it {
#     expect(subject).to implement_update_action(self)
#       .for(resource)
#       .within_form('.edit_partner') {
#         # fill the needed form inputs via capybara here
#         # 
#         # Example:
#         # 
#         #     fill_in 'slider[name]', with: 'New name'
#         fill_in 'address[name]', with: 'ACME Ltd.'
#       }
#       .updating
#       .from(resource.attributes)
#       .to({ "name" => "ACME Ltd." }) # Example: .to({ 'name' => 'New name' })
#   }

#   # Delete
#   it {
#     expect(subject).to implement_delete_action(self)
#       .for(resource)
#       .reducing{ resource_class.count }.by(1)
#   }
# end
