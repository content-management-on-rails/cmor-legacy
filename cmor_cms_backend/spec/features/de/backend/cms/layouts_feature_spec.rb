require 'rails_helper'

RSpec.describe '/de/backend/cms/layouts', type: :feature do
  let(:resource_class) { Cmor::Cms::Layout}
  let(:resource) { create(:cmor_cms_layout) }
  let(:resources) { create_list(:cmor_cms_layout, 3) }

  it { resources; expect(subject).to implement_index_action(self) }

  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_layout') {
        fill_in 'layout[basename]', with: 'mobile'
        fill_in 'layout[body]', with: '<%= yield %>'
        select 'html', from: 'layout[format]'
        select 'erb', from: 'layout[handler]'
      }
      .increasing{ |resource| resource.count }.by(1)
  }
  it { expect(subject).to implement_show_action(self).for(resource) }
  
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_layout') {
        fill_in 'layout[basename]', with: 'responsive'
        fill_in 'layout[body]',     with: 'New body'
      }
      .updating
      .from(resource.attributes)
      .to({ 'basename' => 'responsive', 'body' => 'New body' })
  }

  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end