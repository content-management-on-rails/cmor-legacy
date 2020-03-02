require 'rails_helper'
require 'cmor/legal/frontend/spec_helpers/feature.rb'

RSpec.describe Cmor::Legal::Frontend::SpecHelpers::Feature, type: :system do
  include Cmor::Legal::Frontend::SpecHelpers::Feature

  describe "#accept_eu_gdpr_cookies" do
    it do
      visit(root_path)
      expect(page).to have_selector("#cookies-eu-modal", visible: true)
      accept_eu_gdpr_cookies
      expect(page).not_to have_selector("#cookies-eu-modal", visible: true)
    end
  end
end