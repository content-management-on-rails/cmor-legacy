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
            { success: "success", error: "danger", alert: "warning", notice: "info" }[message_type.to_sym] || message_type.to_s
          end
        end

        # Usage:
        #
        #     # app/views/layouts/application.html.erb
        #     <%= core_helper(self).render_flash %>
        #
        def render_flash
          c.flash.each_with_object({}) do |(key, value), memo|
            memo[map_message_type_to_context(key)] = value
          end
        end

        private

        def map_message_type_to_context(message_type)
          self.class.map_message_type_to_context(message_type)
        end
      end

      include FlashConcern
    end
  end
end