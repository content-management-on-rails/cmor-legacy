module Cmor::UserArea
  module SpecHelpers
    module Feature
      def sign_up(user_attributes)
        visit "/#{I18n.locale}/#{I18n.t('routes.cmor_user_area_engine')}/#{I18n.t('routes.current_user')}/new"

        within('#new_user') do
          fill_in 'user[email]',                 with: user_attributes[:email]
          fill_in 'user[password]',              with: user_attributes[:password]
          fill_in 'user[password_confirmation]', with: user_attributes[:password]

          submit(Cmor::UserArea::User.model_name.human, :create)
        end
      end

      def sign_in(user)
        visit "/#{I18n.locale}/#{I18n.t('routes.cmor_user_area_engine')}/#{I18n.t('routes.user_session')}/new"

        within('#new_user_session') do
          fill_in 'user_session[email]',    with: user.email
          fill_in 'user_session[password]', with: user.password

          click_on I18n.t('helpers.submit.user_session.create')
        end
      end
    end
  end
end