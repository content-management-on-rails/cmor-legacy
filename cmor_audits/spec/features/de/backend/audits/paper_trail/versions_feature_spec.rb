# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/audits/paper_trail/versions", type: :feature do
  let(:resource_class) { ::PaperTrail::Version }
  let(:resource) { create(:paper_trail_version) }
  let(:resources) { create_list(:paper_trail_version, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }

  # Delete
  it {
    expect(subject).to implement_delete_action(self)
      .for(resource)
      .reducing { resource_class.count }.by(1)
  }
end
