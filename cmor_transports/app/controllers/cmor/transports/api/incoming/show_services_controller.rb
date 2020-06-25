module Cmor
  module Transports
    module Api
      module Incoming
        class ShowServicesController < Rao::Api::ServiceController::Base
          protect_from_forgery with: :null_session

          def self.service_class
            Cmor::Transports::Api::Incoming::ShowService
          end

          private

          def permitted_params
            params.require(:show_service).permit(:outgoing_uuid)
          end
        end
      end
    end
  end
end
