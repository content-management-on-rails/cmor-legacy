require 'rails_helper'

RSpec.describe '/de/backend/cms/templates', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:resource_class) { Cmor::Cms::Template}
  let(:resource) { create(:cmor_cms_template) }
  let(:resources) { create_list(:cmor_cms_template, 3) }

  it { resources; expect(subject).to implement_index_action(self) }

  it {
    expect(subject).to implement_create_action(self)
      .for(resource_class)
      .within_form('#new_template') {
        fill_in 'template[basename]', with: 'mobile'
      }
      .increasing{ |resource| resource.count }.by(1)
  }
  it { expect(subject).to implement_show_action(self).for(resource) }
  
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form('.edit_template') {
        fill_in 'template[basename]', with: 'responsive'
        fill_in 'template[body]',     with: 'New body'
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