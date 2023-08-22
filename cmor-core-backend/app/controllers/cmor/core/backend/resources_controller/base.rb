module Cmor
  module Core
    module Backend
      module ResourcesController
        class Base < Administrador::ResourcesController::Base
          if Cmor::Core.features?(:transports)
            include Cmor::Transports::ResourcesController::ExportConcern
            view_helper Cmor::Transports::ExportViewHelper, as: :export_helper
          end

          if Cmor::Core.features?(:cmor_rbac)
            include Cmor::Rbac::ResourcesController::PunditConcern
          end
        end
      end
    end
  end
end