module Cmor::Core::Api
  module Controllers
    # Provides localization support by passing the locale parameter.
    #
    # Example:
    #
    #     # app/controllers/posts_controller.rb
    #     class PostsController < ApplicationController
    #       include Cmor::Core::Api::Controllers::I18nConcern
    #
    #       # ...
    #     end
    #
    #
    #    # config/locales/de.yml
    #    de:
    #      attributes:
    #        post:
    #          body: "Inhalt"
    #
    #
    #     http://localhost:3000/posts?locale=de
    #       => { meta: { attributes: { body: "Inhalt" } } }
    module I18nConcern
      extend ActiveSupport::Concern

      included do
        around_action :switch_locale
      end

      private

      def switch_locale(&action)
        locale = params[:locale] || I18n.default_locale
        I18n.with_locale(locale, &action)
      end
    end
  end
end
