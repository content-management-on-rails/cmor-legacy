module Cmor::Testimonials::Api
  class TestimonialsController < Cmor::Testimonials::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Testimonials::Testimonial
    end

    def self.serializer_class
      Cmor::Testimonials::Api::TestimonialSerializer
    end
  end
end
