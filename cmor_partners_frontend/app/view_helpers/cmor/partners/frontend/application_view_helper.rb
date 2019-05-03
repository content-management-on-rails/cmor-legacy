module Cmor::Partners::Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Partners::Frontend::ApplicationViewHelper, as: :partners_helper
    #     end
    #
  class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/layouts/application.html.haml
      #     = partners_helper(self).render_partners(category_identifier)
      #
    def render_partners(category_identifier, options = {})
      options.reverse_merge!(center_mode: true, slides_to_show: 6, autoplay: true)
      category = Cmor::Partners::Category.where(identifier: category_identifier).first
      render category: category, options: options
    end
  end
end