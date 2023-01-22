module Cmor::Galleries::Api
  class GalleriesController < Cmor::Galleries::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Galleries::PictureGallery
    end

    def self.serializer_class
      Cmor::Galleries::Api::PictureGallerySerializer
    end

    private

    def permitted_params
      params.require(:picture_gallery).permit(:locale, :name, :identifier, :description, :published, { overwrite_picture_detail_assets: [], append_picture_detail_assets: [] })
    end
  end
end
