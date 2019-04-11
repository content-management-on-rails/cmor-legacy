module Cmor::Files
  class ApplicationResourcesController < Cmor::Files::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern
    include Rao::ResourcesController::LocationHistoryConcern
    include Rao::Query::Controller::QueryConcern

    helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

    private

    def load_collection_scope
      with_conditions_from_query(resource_class)
    end
  end
end
