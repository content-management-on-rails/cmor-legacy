require 'rails_helper'

RSpec.describe '/de/backend/system/changelogs', type: :feature do
  let(:resource_class) { Cmor::System::Changelog }
  let(:resource) { Cmor::System::Changelog.first }
  let(:resources) { Cmor::System::Changelog.all }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
