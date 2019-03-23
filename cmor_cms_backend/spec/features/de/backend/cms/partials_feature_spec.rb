require 'rails_helper'

RSpec.describe '/de/backend/cms/partials', type: :feature do
  let(:resource_class) { Cmor::Cms::Partial}
  let(:resource) { create(:cmor_cms_partial) }
  let(:resources) { create_list(:cmor_cms_partial, 3) }

  it { resources; expect(subject).to implement_index_action(self) }
  
  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_partial') {
        fill_in 'partial[basename]', with: '_navigation'
      }
      .increasing{ |resource| resource.count }.by(1)
  }
  
  it { expect(subject).to implement_show_action(self).for(resource) }

  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_partial') {
        fill_in 'partial[basename]', with: '_new_basename'
        fill_in 'partial[body]',     with: 'New body'
      }
      .updating
      .from(resource.attributes)
      .to({ 'basename' => '_new_basename', 'body' => 'New body' })
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end