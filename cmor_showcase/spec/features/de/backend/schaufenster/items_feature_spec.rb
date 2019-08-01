require 'rails_helper'

RSpec.describe '/de/backend/schaufenster/items', type: :feature do
  let(:resource_class) { Cmor::Showcase::Item }
  let(:resource) { create(:cmor_showcase_item) }
  let(:resources) { create_list(:cmor_showcase_item, 3) }

  let(:category) { create(:cmor_showcase_category) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    category
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_item') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select category.name, from: 'item[category_id]'
        fill_in 'item[name]', with: 'ACME'
      }
      .increasing{ Cmor::Showcase::Item.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_item') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'item[name]', with: 'ACME Ltd.'
      }
      .updating
      .from(resource.attributes)
      .to({ "name" => "ACME Ltd." }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
