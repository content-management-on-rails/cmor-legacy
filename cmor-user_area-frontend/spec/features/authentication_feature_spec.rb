require "rails_helper"

RSpec.describe "User Area -> Authentication", type: :feature do
  before(:each) { I18n.locale = :de }

  describe "sign in" do
    context "with an existant user" do
      let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

      before(:each) { user }

      it "should sign in" do
        sign_in(user)
        expect(page.body).to include(I18n.t("messages.success.cmor_user_area_frontend.signed_in"))
      end
    end

    context "with a 2fa enabled user" do
      let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

      before(:each) do
        user.prepare_tfa!
        user.enable_tfa!
      end

      it "should sign in" do
        sign_in(user)
        expect(page.body).to include(I18n.t("messages.success.cmor_user_area_frontend.signed_in"))
      end
    end

    context "with a 2fa backup code" do
      let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

      before(:each) do
        user.prepare_tfa!
        user.enable_tfa!
      end

      it "should sign in" do
        sign_in(user, otp_code: user.otp_backup_codes.first)
        expect(page.body).to include(I18n.t("messages.success.cmor_user_area_frontend.signed_in"))
      end

      it "should remove the used backup code" do
        expect {
          sign_in(user, otp_code: user.otp_backup_codes.first)
        }.to change {
          user.reload.otp_backup_codes.size
        }.from(12).to(11)
      end
    end
  end

  describe "sign out" do
    let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

    before(:each) { sign_in(user) }

    it "should redirect to the home page" do
      click_link("Ausloggen")
      expect(current_path).to eq("/de")
    end
  end # describe 'logout'
end
