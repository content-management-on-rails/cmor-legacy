# frozen_string_literal: true

module Cmor::Legal
  module Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Legal::Frontend::ApplicationViewHelper, as: :legal_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_cookie_consent_banner
        return unless ::Cmor::Legal::Configuration.enable_cookie_consent_banner

        unless c.request.path == c.cmor_legal_frontend.privacy_policy_path(options_for_url_helper) || c.request.path == c.cmor_legal_frontend.edit_cookie_preferences_path(options_for_url_helper)
          c.render('cmor/legal/frontend/cookies/consent_banner') 
        end
      end

      def cookie_preferences_pending?
        cookie_preferences.cookies.any?(&:pending?)
      end

      def cookie_preferences
        ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new(cookie_storage))
      end

      def render_cookie_preferences(options = {})
        options.reverse_merge!(collapsible_preferences: true, show_hint: true)
        collapsible_preferences = options.delete(:collapsible_preferences)
        show_hint = options.delete(:show_hint)

        resource = ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new(cookie_storage))

        c.capture do
          c.concat c.render :partial => 'cmor/legal/frontend/cookie_preferences/hint', locals: { collapsible_preferences: collapsible_preferences } if show_hint
          c.concat c.render :partial => 'cmor/legal/frontend/cookie_preferences/form', locals: { resource: resource, collapsible_preferences: collapsible_preferences }
        end.html_safe
      end

      def options_for_url_helper
        if Gem.loaded_specs["route_translator"].present?
          { locale: I18n.locale }
        elsif Gem.loaded_specs["i18n_routing"].present?
          { i18n_locale: I18n.locale }
        else
          {}
        end
      end

      private

      def cookie_storage
        c.send(::Cmor::Legal::Configuration.cookie_storage)
      end
    end
  end
end
