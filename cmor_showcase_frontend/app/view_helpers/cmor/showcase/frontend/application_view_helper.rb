module Cmor::Showcase
  module Frontend
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Showcase::Frontend::ApplicationViewHelper, as: :showcase_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/layouts/application.html.haml
      #     = showcase_helper(self).render_items(category_identifier)
      #
      def render_items(category_or_identifier, options = {})
        options.reverse_merge!(
          variant_options: Cmor::Showcase::Frontend::Configuration.default_render_items_variant_options,
        )
        variant_options = options.delete(:variant_options)
        category = if category_or_identifier.is_a?(Cmor::Showcase::Category)
          category_or_identifier
        else
          Cmor::Showcase::Category.where(identifier: category_or_identifier).first
        end

        if category.present?
          render category: category, options: options, variant_options: variant_options
        end
      end
    end
  end
end
