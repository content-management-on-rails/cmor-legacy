require 'rails_helper'

RSpec.describe '/de/backend/system/active_storage/attachments', type: :feature do
  let(:user) { create(:cmor_user_area_user, :authenticable) }
  before(:each) { sign_in(user) }

  let(:resource_class) { ActiveStorage::Attachment }
  let(:resource) { create(:active_storage_attachment) }
  let(:resources) { create_list(:active_storage_attachment, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing{ resource_class.count }.by(1)
  }
end
