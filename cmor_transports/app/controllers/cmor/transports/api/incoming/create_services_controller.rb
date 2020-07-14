# frozen_string_literal: true

module Cmor
  module Transports
    module Api
      module Incoming
        class CreateServicesController < Rao::Api::ServiceController::Base
          protect_from_forgery with: :null_session

          def self.service_class
            Cmor::Transports::Api::Incoming::CreateService
          end

          private
          def permitted_params
            params.require(:create_service).permit(outgoing: [:id, :uuid, :state, :creator_type, :creator_id, :job_id, :service_messages, :service_errors, :description, :created_at, :updated_at, :output_base64])
          end
        end
      end
    end
  end
end
