module Cmor
  module Files
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Files::ApplicationViewHelper, as: :files_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = files_helper(self).render_download(identifier: 'Quick reference manual')
      #
      def render_file(identifier:)
        resource = Cmor::Files::FileDetail.published.where(identifier: identifier).first
        if resource.nil?
          "Could not find published file detail with identifier: '#{identifier}'."
        else
          render resource: resource
        end
      end
    end
  end
end
