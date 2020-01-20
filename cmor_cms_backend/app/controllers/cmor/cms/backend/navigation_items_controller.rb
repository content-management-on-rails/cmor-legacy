module Cmor
  module Cms
    module Backend
      class NavigationItemsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::AwesomeNestedSetConcern
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Cms::NavigationItem
        end

        private

        def load_collection_scope
          super.joins(:navigation).includes(:page)
        end

        def permitted_params
          params.require(:navigation_item)
                .permit(:navigation_id, :page_id, :highlights_on, :key, :name, :parent_id, :options, :url, :published, *Cmor::Cms::Configuration.navigation_item_properties)
        end
      end
    end
  end
end
