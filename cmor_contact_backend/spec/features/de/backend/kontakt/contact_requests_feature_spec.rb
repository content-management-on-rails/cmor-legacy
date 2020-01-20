require 'rails_helper'

RSpec.describe '/de/backend/kontakt/contact_requests', type: :feature do
  let(:resource_class) { Cmor::Contact::ContactRequest }
  let(:resource) { create(:cmor_contact_contact_request) }
  let(:resources) { create_list(:cmor_contact_contact_request, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }
  
  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Destroy
  it {
  expect(subject).to implement_delete_action(self)
    .for(resource)
    .reducing{ resource_class.count }.by(1)
  }
end
