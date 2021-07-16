# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/sicherheit/antivirus_configurations", type: :feature do
  let(:resource_class) { Cmor::Security::AntivirusConfiguration }
  let(:resource) { Cmor::Security::AntivirusConfiguration.first }
  let(:resources) { Cmor::Security::AntivirusConfiguration.all }

  # List
  it { resources; expect(subject).to implement_index_action(self) }
end
