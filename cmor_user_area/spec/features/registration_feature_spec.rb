require 'rails_helper'
require 'cmor/user_area/spec_helpers/feature'

feature 'User Area -> Registration' do
  include Cmor::UserArea::SpecHelpers::Feature

  background do
    I18n.locale = :de
  end

  describe 'new registration' do
    context 'when not signed in' do
      background do
        @user_attributes = attributes_for(:cmor_user_area_user)
      end

      it 'should create a user' do
        expect { sign_up(@user_attributes) }.to change { Cmor::UserArea::User.count }.from(0).to(1)
      end

      it 'should redirect to root' do
        sign_up(@user_attributes)
        expect(page.current_path).to eq(main_app.root_path)
      end

      it 'should show a success message' do
        sign_up(@user_attributes)
        expect(page.body).to include(I18n.t('messages.confirmations.cmor_user_area.send_instructions'))
      end
    end
  end

  describe 'editing a registration' do
    let(:edit_current_user_path) { "/de/benutzer/profil/edit" }
    context 'when signed in' do
      background do
        @user = Cmor::UserArea::CreateDefaultUserService.call.user
        sign_in(@user)
      end

      it 'should allow access' do
        visit(edit_current_user_path)
        page.current_path.should eq(edit_current_user_path)
      end

      context 'changing email' do
        let(:new_user_session_path) { "/de/benutzer/session/new" }
        
        background do
          visit(edit_current_user_path)
        end

        it do
          expect do
            fill_in 'user[email]', with: 'new@example.com'
            click_on submit(Cmor::UserArea::User.model_name.human, :update)
          end.to change {
            @user.reload
            @user.email
          }.from(@user.email).to('new@example.com')
        end

        it 'should sign out' do
          fill_in 'user[email]', with: 'new@example.com'
          click_on submit(Cmor::UserArea::User.model_name.human, :update)

          expect(page.current_path).to eq(new_user_session_path)
        end
      end
    end

    context 'when not signed in' do
      let(:new_user_session_path) { "/de/benutzer/session/new" }
      
      it 'should redirect to the sign in page' do
        visit(edit_current_user_path)
        page.current_path.should eq(new_user_session_path)
      end
    end
  end
end
