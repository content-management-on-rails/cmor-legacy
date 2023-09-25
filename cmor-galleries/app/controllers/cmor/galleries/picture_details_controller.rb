module Cmor
  module Galleries
    class PictureDetailsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsPublishedConcern
      include Rao::ResourcesController::ActsAsListConcern

      helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

      def self.resource_class
        Cmor::Galleries::PictureDetail
      end

      def self.available_rest_actions
        super - %i[new create]
      end

      private

      def load_collection_scope
        super.joins(:picture_gallery).order(picture_gallery_id: :asc, position: :asc)
      end

      def after_destroy_location
        last_location == url_for(action: :show) ? url_for(action: :index) : last_location
      end

      def permitted_params
        params.require(:picture_detail).permit(:title, :identifier, :description, :picture_gallery_id, :published)
      end
    end
  end
end
