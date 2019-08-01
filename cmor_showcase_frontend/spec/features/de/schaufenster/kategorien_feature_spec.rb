require 'rails_helper'

RSpec.describe '/de/schaufenster/kategorien', type: :feature do
  let(:resource_class) { Cmor::Showcase::Category }
  let(:resource) { create(:cmor_showcase_category) }
  let(:resources) { create_list(:cmor_showcase_category, 3) }

  # List
  it { resources; expect(subject).to implement_index_action(self) }

  # Read
  it { expect(subject).to implement_show_action(self).for(resource) }
end
