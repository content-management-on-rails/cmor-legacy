module Cmor::Carousels::Api
  class CarouselsController < Cmor::Carousels::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::Carousel
    end

    def self.serializer_class
      Cmor::Carousels::Api::CarouselSerializer
    end
  end
end
