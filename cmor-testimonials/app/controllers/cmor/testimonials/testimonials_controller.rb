module Cmor::Testimonials
  class TestimonialsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Testimonials::Testimonial
    end

    private

    def load_collection_scope
      super.eager_load(:category)
    end

    def permitted_params
      params.require(:testimonial).permit(:category_id, :fullname, :role, :company, :body, :published, :image)
    end

    def after_reposition_location
      request.headers["Referer"] || super
    end
  end
end
