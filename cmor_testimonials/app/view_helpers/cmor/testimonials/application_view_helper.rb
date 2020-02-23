module Cmor
  module Testimonials
    # Example:
    #
    #     # app/controllers/application_controller.rb
    #     class ApplicationController < ActionController::Base
    #       view_helper Cmor::Testimonials::ApplicationViewHelper, as: :testimonials_helper
    #     end
    #
    class ApplicationViewHelper < Rao::ViewHelper::Base
      # Example:
      #
      #     # app/views/layouts/application.html.haml
      #     = testimonials_helper(self).render_category(category_identifier)
      #
      def render_category(category_or_identifier, options = {})
        default_variant_options = Cmor::Testimonials::Configuration.image_variant_options[:category]
        options.reverse_merge!(
          autostart:            true,
          interval:             5.0,
          keyboard:             true,
          pause:                :hover,
          ride:                 false,
          wrap:                 true,
          controls:             true,
          indicators:           false,
          variant_options:      default_variant_options,
          font_awesome:         false,
          show_image:           true,
          control_html:         { class: 'text-dark' },
          image_container_html: { class: 'col-12 text-center'},
          text_container_html:  { class: 'col-12 text-center'},
        )
        category = if category_or_identifier.is_a?(Cmor::Testimonials::Category)
          category_or_identifier
        else
          Cmor::Testimonials::Category.where(identifier: category_or_identifier).first
        end

        if category.present? && category.testimonials.published.any?
          render category: category, options: options
        end
      end
    end
  end
end