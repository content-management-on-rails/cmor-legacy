require 'rails_helper'

RSpec.describe "/de/benutzer/profil/2fa-einrichtung/new" do
  let(:base_path) { "/de/benutzer/profil/2fa-einrichtung/new" }

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
      let(:page_text) { "Zwei Faktor Autentifizierung einrichten" }

      before(:each) { visit(base_path) }

      it { expect(current_path).to eq(base_path) }
      it { expect(page.body).to have_text(page_text) }
    end

    describe "changes" do
      it { expect{ visit(base_path) }.to change{ user.reload.tfa_state }.from("disabled").to("in_preparation") }
      it { expect{ visit(base_path) }.to change{ user.reload.otp_backup_codes.size }.from(0).to(10) }
    end
    
    describe "enabling 2fa" do
      let(:submit_button) { find("button[type=submit]") }

      before(:each) do
        visit(base_path)
        fill_in "two_factor_authentication_setup_service[code]", with: user.reload.otp_code
      end
      
      describe "response" do
        let(:after_success_path) { "/de/benutzer/profil" }

        before(:each) do
          submit_button.click
        end

        it { expect(current_path).to eq(after_success_path) }
      end

      describe "changes" do
        it { expect{ submit_button.click }.to change{ user.reload.tfa_state }.from("in_preparation").to("enabled") }
      end
    end
  end
end
