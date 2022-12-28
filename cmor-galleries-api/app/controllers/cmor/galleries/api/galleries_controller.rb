module Cmor::Galleries::Api
  class GalleriesController < Cmor::Galleries::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Galleries::PictureGallery
    end

    def self.serializer_class
      Cmor::Galleries::Api::PictureGallerySerializer
    end
  end
end
