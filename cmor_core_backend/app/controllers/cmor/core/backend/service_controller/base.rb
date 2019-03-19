module Cmor
  module Core
    module Backend
      module ServiceController
        class Base < Administrador::ServiceController::Base
        # class Base < Cmor::Core::Backend::Configuration.service_controller_base_class_name.constantize
        #   include Administrador::Controller::ApplicationConcern
        #   include Administrador::Controller::ServiceConcern
        end
      end
    end
  end
end