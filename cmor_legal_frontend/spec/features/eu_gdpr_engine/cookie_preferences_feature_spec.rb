require 'rails_helper'

RSpec.describe '/de/cookie-einstellungen/edit', type: :feature, js: true do
  let(:base_path) { '/de/cookie-einstellungen' }
  let(:edit_path) { "#{base_path}/edit" }

  describe 'ui' do
    before(:each) { visit(edit_path) }

    it { expect(current_path).to eq(edit_path) }
  end

  describe 'defaults' do
    let(:cookie_store) { Cmor::Legal::CookieStore.new({}) }
    before(:each) do
      Cmor::Legal::Configuration.cookies = ->(cookie_store) do
      [
        Cmor::Legal::Cookie.new(identifier: :basic,        adjustable: false, default: true,  cookie_store: cookie_store),
        Cmor::Legal::Cookie.new(identifier: :analytics,    adjustable: true,  default: true,  cookie_store: cookie_store),
        Cmor::Legal::Cookie.new(identifier: :marketing,    adjustable: true,  default: true,  cookie_store: cookie_store),
        Cmor::Legal::Cookie.new(identifier: :social_media, adjustable: true,  default: false, cookie_store: cookie_store)
      ]
      end
      visit(edit_path)
    end
    
    it { expect(page).to have_field('cmor_legal_cookie_checkbox_basic', disabled: true) }
    it { expect(page.find("input#cmor_legal_cookie_checkbox_basic")).to be_checked }
    it { expect(page.find("input#cmor_legal_cookie_checkbox_basic")).to be_checked }
    it { expect(page.find("input#cmor_legal_cookie_checkbox_analytics")).to be_checked }
    it { expect(page.find("input#cmor_legal_cookie_checkbox_marketing")).to be_checked }
    it { expect(page.find("input#cmor_legal_cookie_checkbox_social_media")).not_to be_checked }
  end

  describe 'enabling a cookie' do
    let(:sucess_message) { I18n.t('cmor.legal.frontend.cookie_preferences.update.success') }
    let(:cookie_store) { Cmor::Legal::CookieStore.new({}) }
    before(:each) do
      Cmor::Legal::Configuration.cookies = ->(cookie_store) do
      [
        Cmor::Legal::Cookie.new(identifier: :basic, adjustable: true, default: false,  cookie_store: cookie_store)
      ]
      end
      visit(edit_path)
    end
    
    it do
      # First make sure we have
      expect(page).to have_field('cmor_legal_cookie_checkbox_basic')
      expect(page.find("input#cmor_legal_cookie_checkbox_basic")).not_to be_checked

      # Check and submit
      page.find("input#cmor_legal_cookie_checkbox_basic").set(true)
      within('#new_cookie_preferences') { find("input[type='submit']").click }

      # Check result
      expect(current_path).to eq(edit_path)
      expect(page.body).to include(sucess_message)

      expect(page.find("input#cmor_legal_cookie_checkbox_basic")).to be_checked
    end
  end
end
