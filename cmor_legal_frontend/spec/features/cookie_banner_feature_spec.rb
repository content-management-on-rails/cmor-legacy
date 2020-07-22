# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Cookie Banner", type: :system do
  describe "visibility" do
    before(:each) do
      visit "/"
    end

    it { expect(page.body).to have_css("#cookies-eu-modal") }
  end

  describe "accepting cookies" do
    before(:each) do
      visit "/"
      within("#cookies-eu-modal") { find("input[type=submit]").click }
    end

    it { expect(current_path).to eq("/") }
    it { expect(page.body).to have_text(I18n.t('cmor.legal.frontend.cookie_preferences.update.success')) }
  end

  describe "forwarding of url paramters" do
    let(:query_string) { "foo=bar" }
    before(:each) do
      visit "/?#{query_string}"
      within("#cookies-eu-modal") { find("input[type=submit]").click }
    end

    it { expect(current_path).to eq("/") }
    it { expect(page.body).to have_text(I18n.t('cmor.legal.frontend.cookie_preferences.update.success')) }
    it { expect(current_url.split("?").last).to eq(query_string) }
  end

  describe "redirects back to the original path" do
    before(:each) do
      visit "/foo"
      within("#cookies-eu-modal") { find("input[type=submit]").click }
    end

    it { expect(current_path).to eq("/foo") }
    it { expect(page.body).to have_text(I18n.t('cmor.legal.frontend.cookie_preferences.update.success')) }
  end
end
