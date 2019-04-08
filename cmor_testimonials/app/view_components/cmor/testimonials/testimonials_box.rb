module Cmor
  module Testimonials
    class TestimonialsBox < ViewComponent

      attr_accessor :category_identifier

      validates_presence_of :category_identifier

      def testimonials
        @testimonials = Cmor::Testimonials::Category.find_by_identifier(category_identifier).try(:testimonials)
      end
    end
  end
end