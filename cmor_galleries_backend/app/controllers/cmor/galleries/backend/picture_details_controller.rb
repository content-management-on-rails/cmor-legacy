module Cmor
  module Galleries
    module Backend
      class PictureDetailsController < Cmor::Core::Backend::ResourcesController::Base
        helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

        def self.resource_class
          Cmor::Galleries::PictureDetail
        end

        def self.available_rest_actions
          super - %i(new)
        end

        private

        def load_collection_scope
          scope = super.joins(:picture_gallery).order(picture_gallery_id: :asc, position: :asc)
          with_conditions_from_query(scope)
        end

        def after_destroy_location
          last_location
        end

        def permitted_params
          params.require(:picture_detail).permit(:title, :description, :picture_gallery_id, :published)
        end
      end
    end
  end
end
