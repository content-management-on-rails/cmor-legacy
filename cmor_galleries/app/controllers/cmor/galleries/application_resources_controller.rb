module Cmor::Galleries
  class ApplicationResourcesController < Cmor::Galleries::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern
    include Rao::ResourcesController::LocationHistoryConcern
  end
end
