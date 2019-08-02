require 'rails_helper'

RSpec.describe '/de/schaufenster/eintraege', type: :feature do
  let(:resource_class) { Cmor::Showcase::Item }
  let(:resource) { create(:cmor_showcase_item) }
  # let(:resources) { create_list(:cmor_showcase_item, 3) }

  # List
  # it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
