# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/de/backend/juristisches/privacy_policies", type: :feature do
  let(:resource_class) { Cmor::Legal::PrivacyPolicy }
  let(:resource) { create(:cmor_legal_privacy_policy) }
  let(:resources) { I18n.available_locales.map { |l| create(:cmor_legal_privacy_policy, locale: l) } }

  describe 'REST Actions' do
    # List
    it { resources; expect(subject).to implement_index_action(self) }

    # Create
    it {
      expect(subject).to implement_create_action(self)
        .for(resource_class)
        .within_form("#new_privacy_policy") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     select 'de', from: 'slider[locale]'
          #     fill_in 'slider[name]', with: 'My first slider'
          #     check 'slider[auto_start]'
          #     fill_in 'slider[interval]', with: '3'
          select I18n.locale, from: "privacy_policy[locale]"
          fill_in "privacy_policy[title]", with: "Privacy Policy"
          fill_in "privacy_policy[body]", with: "<h1>Privacy Policy</h1>"
        }
        .increasing { Cmor::Legal::PrivacyPolicy.published.count }.by(1)
    }

    # Read
    it { expect(subject).to implement_show_action(self).for(resource) }

    # Update
    it {
      expect(subject).to implement_update_action(self)
        .for(resource)
        .within_form(".edit_privacy_policy") {
          # fill the needed form inputs via capybara here
          #
          # Example:
          #
          #     fill_in 'slider[name]', with: 'New name'
          fill_in "privacy_policy[body]", with: "<h1>Privacy Policy (v2.0)</h1>"
        }
        .updating
        .from(resource.attributes)
        .to("body" => "<h1>Privacy Policy (v2.0)</h1>") # Example: .to({ 'name' => 'New name' })
    }

    # Delete
    it {
      expect(subject).to implement_delete_action(self)
        .for(resource)
        .reducing { resource_class.count }.by(1)
    }
  end
end
