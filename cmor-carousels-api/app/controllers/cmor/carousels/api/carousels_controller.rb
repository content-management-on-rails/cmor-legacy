module Cmor::Carousels::Api
  class CarouselsController < Cmor::Carousels::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::Carousel
    end

    def self.serializer_class
      Cmor::Carousels::Api::CarouselSerializer
    end

    private

    def permitted_params
      params.require(:carousel).permit(:identifier, :locale, :height, :width, { overwrite_item_detail_assets: [], append_item_detail_assets: [] })
    end
  end
end
