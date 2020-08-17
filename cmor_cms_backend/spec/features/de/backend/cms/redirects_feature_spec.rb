require 'rails_helper'

RSpec.describe '/de/backend/cms/redirects', type: :feature do
  let(:resource_class) { Cmor::Cms::Redirect }
  let(:resource) { create(:cmor_cms_redirect) }
  let(:resources) { create_list(:cmor_cms_redirect, 3) }

  it { resources; expect(subject).to implement_index_action(self) }
  
  it {
    expect(subject).to implement_create_action(self)
      .for(Cmor::Cms::Redirect)
      .within_form('#new_redirect') {
        fill_in 'redirect[source]', with: '/source'
        fill_in 'redirect[target]', with: '/target'
      }
      .increasing{ |resource| resource.count }.by(1)
  }
  
  it { expect(subject).to implement_show_action(self).for(resource) }
  
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
