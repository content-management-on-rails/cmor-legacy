require 'rails_helper'

RSpec.describe '/de/backend/schaufenster/categories', type: :feature do
  let(:resource_class) { Cmor::Showcase::Category }
  let(:resource) { create(:cmor_showcase_category) }
  let(:resources) { create_list(:cmor_showcase_category, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Create
  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_category') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        select 'de', from: 'category[locale]'
        fill_in 'category[identifier]', with: 'category-1'
        fill_in 'category[name]', with: 'Webseiten'
      }
      .increasing{ Cmor::Showcase::Category.count }.by(1)
  }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_category') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'category[name]', with: 'CI'
      }
      .updating
      .from(resource.attributes)
      .to({ 'name' => 'CI' }) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
