require 'rails_helper'
require 'cmor/user_area/spec_helpers/feature'

RSpec.describe 'User Area -> Authentication', type: :feature do
  include Cmor::UserArea::SpecHelpers::Feature

  before(:each) { I18n.locale = :de }

  describe 'sign in' do
    context 'with an existant user' do
      let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

      before(:each) { user }

      it 'should sign in' do
        sign_in(@user)
        expect(page.body).to include(I18n.t('messages.success.cmor_user_area.signed_in'))
      end
    end
  end

  describe 'sign out' do
    let(:user) { Cmor::UserArea::CreateDefaultUserService.call.user }

    before(:each) { sign_in(user) }

    it 'should redirect to the home page' do
      click_link('Ausloggen')
      page.current_path.should eq('/de')
    end
  end # describe 'logout'
end
