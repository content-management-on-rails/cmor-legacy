require 'rails_helper'

RSpec.describe '/de/datenschutzerklaerung', type: :feature do
  let(:privacy_policy_path) { "/de/datenschutzerklaerung" }

  before(:each) do
    Cmor::Legal::PrivacyPolicy.create!(published: true, title: "Datenschutzerklärung", body: "h1. Datenschutzerklärung")
    visit(privacy_policy_path)
  end

  it { expect(current_path).to eq(privacy_policy_path) }
  it { expect(page.body).to include("<h1>Datenschutzerklärung</h1>") }
end