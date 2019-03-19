module Cmor::Galleries
  class PictureGalleriesController < ApplicationResourcesController
    def self.resource_class
      Cmor::Galleries::PictureGallery
    end

    private

    def load_collection_scope
      super.published
    end

    def load_resource_scope
      super.published
    end
  end
end
