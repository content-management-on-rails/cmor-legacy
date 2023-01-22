module Cmor::Testimonials::Api
  class TestimonialsController < Cmor::Testimonials::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Testimonials::Testimonial
    end

    def self.serializer_class
      Cmor::Testimonials::Api::TestimonialSerializer
    end

    private

    def permitted_params
      params.require(:testimonial).permit(:category_id, :fullname, :role, :company, :body, :published, :image)
    end
  end
end
