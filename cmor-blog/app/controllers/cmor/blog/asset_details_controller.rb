module Cmor
  module Blog
    class AssetDetailsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsListConcern
      include Rao::ResourcesController::ActsAsPublishedConcern
      include Rao::ResourcesController::SortingConcern

      helper Twitter::Bootstrap::Components::Rails::V3::ComponentsHelper

      def self.resource_class
        Cmor::Blog::AssetDetail
      end

      def self.available_rest_actions
        super - [:new, :create]
      end

      private

      def after_destroy_location
        last_location
      end

      def after_reposition_location
        last_location
      end

      def permitted_params
        params.require(:asset_detail).permit(:title, :description, :published)
      end
    end
  end
end
