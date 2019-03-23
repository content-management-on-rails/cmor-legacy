require 'rails_helper'

RSpec.describe '/de/backend/tags/tags', type: :feature do
  let(:resource_class) { Cmor::Tags::Tag }
  let(:resource) { create(:cmor_tags_tag) }
  let(:resources) { create_list(:cmor_tags_tag, 3) }

  it { resources; expect(subject).to implement_index_action(self) }

  it { 
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_tag') {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     select 'de', from: 'slider[locale]'
        #     fill_in 'slider[name]', with: 'My first slider'
        #     check 'slider[auto_start]'
        #     fill_in 'slider[interval]', with: '3'
        fill_in 'tag[name]', with: 'My fancy tag'
      }
      .increasing{ Cmor::Tags::Tag.count }.by(1)
  }
  
  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_tag') {
        # fill the needed form inputs via capybara here
        # 
        # Example:
        # 
        #     fill_in 'slider[name]', with: 'New name'
        fill_in 'tag[name]', with: 'My fancy renamed tag'
      }
      .updating
      .from(resource.attributes)
      .to({ 'name' => 'My fancy renamed tag' })
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
