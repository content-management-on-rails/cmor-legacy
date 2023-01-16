module Cmor::Carousels
  class CarouselsController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::Carousel
    end

    private

    def permitted_params
      params.require(:carousel).permit(:identifier, :locale, :height, :width, {overwrite_item_detail_assets: [], append_item_detail_assets: []})
    end
  end
end
