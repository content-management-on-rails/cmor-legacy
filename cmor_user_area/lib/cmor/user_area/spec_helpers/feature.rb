module Cmor::UserArea
  module SpecHelpers
    # Usage:
    #
    #    # spec/support/cmor_user_area.rb
    #    require 'cmor/user_area/spec_helpers/feature'
    #
    #    RSpec.configure do |config|
    #      config.include Cmor::UserArea::SpecHelpers::Feature, type: :feature
    #      config.include Cmor::UserArea::SpecHelpers::Feature, type: :system
    #    end
    #
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

      # Example:
      #
      #    # spec/features/de/backend/blog/posts
      #    require 'rails_helper'
      #
      #    RSpec.describe '/de/backend/blog/posts', type: :feature do
      #      let(:user) { create(:cmor_user_area_user, :authenticable) }
      #      before(:each) { sign_in(user) }
      #
      #      let(:base_path) { "/de/backend/blog/posts" }
      #      it { visit(base_path); expect(page).to have_text("Posts") }
      #    end
      #
      def sign_in(user)
        visit "/#{I18n.locale}/#{I18n.t('routes.cmor_user_area_engine')}/#{I18n.t('routes.user_session')}/new"

        within('#new_user_session') do
          fill_in 'user_session[email]',    with: user.email
          fill_in 'user_session[password]', with: user.password

          click_on I18n.t('helpers.submit.user_session.create')
        end
      end

      # Enables the registrations feature, so you can signup users.
      #
      # Usage:
      #
      #     # spec/features/registrations_feature_spec.rb
      #     require 'rails_helper'
      #     require 'cmor/user_area/spec_helpers/feature'
      #
      #     RSpec.feature 'Registrations', type: :feature do
      #       include Cmor::UserArea::SpecHelpers::Feature
      #
      #       around(:each) { |example| with_enabled_registrations { example } }
      #
      #       it do
      #         expect { sign_up(user_attributes) }.to change { Cmor::UserArea::User.count }.from(0).to(1)
      #       end
      #     end
      #
      def with_enabled_registrations
        _setup_enabled_registrations
        yield
        _undo_setup_enabled_registrations
      end

      def _setup_enabled_registrations
        @_enabled_registrations = Cmor::UserArea.enable_registrations
        Cmor::UserArea.enable_registrations = true
      end

      def _undo_setup_enabled_registrations
        Cmor::UserArea.enable_registrations = @_enabled_registrations
        remove_instance_variable(:@_enabled_registrations)
      end
    end
  end
end