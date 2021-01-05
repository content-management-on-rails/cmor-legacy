require 'rails_helper'

RSpec.describe "/de/benutzer/profil" do
  let(:base_path) { "/de/benutzer/profil" }

  describe "when not authenticated" do
    describe "response" do
      let(:authentication_failed_path) { "/#{I18n.locale}/#{I18n.t('routes.cmor_user_area_engine')}/#{I18n.t('routes.user_session')}/new" }
      
      before(:each) { visit(base_path) }

      it { expect(current_path).to eq(authentication_failed_path) }
    end
  end

  describe "when authenticated" do
    let(:user) { create(:cmor_user_area_user, :authenticable) }

    before(:each) { sign_in(user) }

    describe "response" do
      before(:each) { visit(base_path) }

      it { expect(current_path).to eq(base_path) }
      it { expect(page.body).to have_text(user.email) }
    end
  end

  describe "when 2fa is enabled" do
    let(:user) { create(:cmor_user_area_user, :authenticable) }

    before(:each) do
      allow(Cmor::UserArea::Configuration).to receive(:tfa_enabled?).and_return(true)
      sign_in(user, with_tfa: false)
      visit(base_path)
    end

    it { expect(page.body).to have_text(Cmor::UserArea::User.human_attribute_name(:tfa_state))}
  end

  describe "when 2fa is disabled" do
    let(:user) { create(:cmor_user_area_user, :authenticable) }

    before(:each) do
      allow(Cmor::UserArea::Configuration).to receive(:tfa_enabled?).and_return(false)
      sign_in(user, with_tfa: false)
      visit(base_path)
    end

    it { expect(page.body).not_to have_text(Cmor::UserArea::User.human_attribute_name(:tfa_state))}
  end
end
