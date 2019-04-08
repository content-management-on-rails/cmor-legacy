module Cmor
  module Testimonials
    module ComponentHelper
      def render_testimonials(props)
        Cmor::Testimonials::TestimonialsBox.new({ context: self }.merge(props)).render
      end
    end
  end
end