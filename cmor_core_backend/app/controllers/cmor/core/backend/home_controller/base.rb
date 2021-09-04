module Cmor
  module Core
    module Backend
      class HomeController::Base < Administrador::HomeController::Base
        if Cmor::Core.features?(:cmor_rbac)
          include Cmor::Rbac::HomeController::PunditConcern
        end

        def index; end
      end
    end
  end
end