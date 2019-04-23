module Cmor
  module Testimonials
    class ApplicationViewHelper < Rao::ViewHelper::Base
      def render_category(identifier, options = {})
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
        category = Cmor::Testimonials::Category.where(identifier: identifier).first

        if category.present?
          render category: category, options: options
        end
      end

      private

      def render(locals = {})
        c.render partial: "/#{self.class.name.underscore}/#{caller_locations(1,1)[0].label}", locals: locals
      end
    end
  end
end