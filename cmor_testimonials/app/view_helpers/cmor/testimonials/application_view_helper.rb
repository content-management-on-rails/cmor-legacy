module Cmor
  module Testimonials
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_category(category_or_identifier, options = {})
        default_variant_options = Cmor::Testimonials::Configuration.image_variant_options[:category]
        options.reverse_merge!(
          autostart:       true,
          interval:        5.0,
          keyboard:        true,
          pause:           :hover,
          ride:            false,
          wrap:            true,
          controls:        true,
          indicators:      false,
          variant_options: default_variant_options,
          font_awesome:    false
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