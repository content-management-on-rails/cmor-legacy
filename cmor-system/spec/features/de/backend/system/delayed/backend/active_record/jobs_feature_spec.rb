require "rails_helper"
require "delayed_job_active_record"

RSpec.describe "/de/backend/system/delayed/backend/active_record/jobs", type: :feature do
  let(:resource_class) { Delayed::Backend::ActiveRecord::Job }
  let(:resource) { create(:delayed_backend_active_record_job) }
  let(:resources) { create_list(:delayed_backend_active_record_job, 3) }

  # List
  it {
    resources
    expect(subject).to implement_index_action(self)
  }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Update
  it {
    expect(subject).to implement_update_action(self)
      .for(resource)
      .within_form(".edit_delayed_backend_active_record_job") {
        # fill the needed form inputs via capybara here
        #
        # Example:
        #
        #     fill_in 'slider[name]', with: 'New name'
        fill_in "delayed_backend_active_record_job[queue]", with: "different_queue"
      }
      .updating
      .from(resource.attributes)
      .to({"queue" => "different_queue"}) # Example: .to({ 'name' => 'New name' })
  }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
