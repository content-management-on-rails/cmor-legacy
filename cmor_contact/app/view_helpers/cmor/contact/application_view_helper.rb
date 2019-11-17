module Cmor
  module Contact
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Contact::ApplicationViewHelper, as: :contact_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = contact_helper(self).render_whatsapp_widget
      #
      def render_whatsapp_widget(options = {})
        resource = Cmor::Contact::WhatsappRequest.new
        render resource: resource
      end
    end
  end
end
