module Cmor::Carousels::Backend
  class CarouselsController < Cmor::Core::Backend::ResourcesController::Base
    def self.resource_class
      Cmor::Carousels::Carousel
    end

    private

    def permitted_params
      params.require(:carousel).permit(:identifier, :locale, :height, :width, { assets: [], overwrite_assets: [], append_assets: [] })
    end
  end
end
