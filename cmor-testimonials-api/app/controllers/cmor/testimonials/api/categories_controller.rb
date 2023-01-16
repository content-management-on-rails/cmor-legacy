module Cmor::Testimonials::Api
  class CategoriesController < Cmor::Testimonials::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Testimonials::Category
    end

    def self.serializer_class
      Cmor::Testimonials::Api::CategorySerializer
    end
  end
end
