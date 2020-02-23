module Cmor
  module Galleries
    module Backend
      class PictureGalleriesController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::FriendlyIdConcern
        include Rao::ResourcesController::ActsAsPublishedConcern
        include Rao::ResourcesController::ActsAsListConcern

        helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

        def self.resource_class
          Cmor::Galleries::PictureGallery
        end

        private

        def permitted_params
          params.require(:picture_gallery).permit(:locale, :name, :description, :published, { assets: [], overwrite_assets: [], append_assets: [] })
        end
      end
    end
  end
end
