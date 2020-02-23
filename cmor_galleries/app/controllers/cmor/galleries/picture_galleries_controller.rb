module Cmor
  module Galleries
    class PictureGalleriesController < ApplicationResourcesController
      include Rao::ResourcesController::FriendlyIdConcern

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
end
