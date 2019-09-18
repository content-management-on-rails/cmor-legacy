module Cmor
  module Tags
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Tags::ApplicationViewHelper, as: :tags_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/posts/_post.html.haml
      #     = tags_helper(self).render_tags_for(post)
      #
      def render_tags_for(resource)
        render resource: resource
      end
    end
  end
end
