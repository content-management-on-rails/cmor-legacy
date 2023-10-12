module Cmor
  module Core
    # Usage:
    #
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Core::ApplicationViewHelper, as: :core_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      module FlashConcern
        extend ActiveSupport::Concern

        included do
          def map_message_type_to_context(message_type)
            {success: "success", error: "danger", alert: "warning", notice: "info"}[message_type.to_sym] || message_type.to_s
          end
        end

        # Usage:
        #
        #     # app/views/layouts/application.html.erb
        #     <%= core_helper(self).render_flash %>
        #
        def render_flash
          messages = c.flash.each_with_object({}) do |(key, value), memo|
            memo[map_message_type_to_context(key)] = value
          end
          render(messages: messages)
        end

        private

        def map_message_type_to_context(message_type)
          self.class.map_message_type_to_context(message_type)
        end
      end

      include FlashConcern

      module PageTitleConcern
        extend ActiveSupport::Concern

        def application_title
          t("#{Rails.application.class.to_s.deconstantize.underscore}.application.name")
        end

        def page_title
          page_title = t(page_title_i18n_key, default: page_title_fallbacks)
          [application_title, page_title].join(" - ")
        end

        private

        def page_title_fallbacks
          page_title_from_content || page_title_from_resource
        end

        def page_title_i18n_key
          splitted_controller_name = c.params[:controller].split("/")
          controller_namespace = splitted_controller_name[0..1].join(".")
          controller_demodulized_name = splitted_controller_name.last

          [controller_namespace, "pages", controller_demodulized_name, c.controller.action_name].join(".")
        end

        def page_title_from_resource
          if (resource = c.controller.instance_variable_get(:@resource)).respond_to?(:title)
            resource.title
          end
        end

        def page_title_from_content
          c.content_for(:title)
        end
      end

      include PageTitleConcern
    end
  end
end
