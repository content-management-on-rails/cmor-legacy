module Cmor
  module Core
    module Backend
      module ServiceController
        class Base < Administrador::ServiceController::Base
          if Cmor::Core.features?(:cmor_rbac)
            include Cmor::Rbac::ServiceController::PunditConcern
          end
        end
      end
    end
  end
end