module Cmor
  module Testimonials
    module ComponentHelper
      def render_testimonials(props)
        render_component(Cmor::Testimonials::TestimonialsBox, props)
      end

      def render_component(component, props)
        component.new({ context: self }.merge(props)).render
      end
    end
  end
end