module Cmor
  module Invoicing
    module Api
      module ResourcesController
        class Base < Cmor::Invoicing::Api::ApplicationController
          include Rao::Api::ResourcesController::RestActionsConcern
          include Rao::Api::ResourcesController::ResourcesConcern
          include Rao::Api::ResourcesController::CountActionConcern
          include Rao::Api::ResourcesController::DestroyAllActionConcern
          include Rao::Api::ResourcesController::DeleteAllActionConcern
          include Rao::Api::ResourcesController::FirstActionConcern
          include Rao::Api::ResourcesController::LastActionConcern
          include Rao::Api::ResourcesController::ExceptionHandlingConcern
          include Rao::Query::Controller::QueryConcern
          include Cmor::Invoicing::Api::ResourcesController::SerializationConcern
          include Cmor::Invoicing::Api::ResourcesController::SortingConcern
        end
      end
    end
  end
end
