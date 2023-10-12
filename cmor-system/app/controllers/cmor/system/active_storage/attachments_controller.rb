module Cmor
  module System
    module ActiveStorage
      class AttachmentsController < Cmor::Core::Backend::ResourcesController::Base
        include Cmor::Audits::ResourcesController::PaperTrailConcern if Cmor::Core.features?(:cmor_audits)

        def self.engine_class
          ::Cmor::System::Engine
        end

        def self.resource_class
          ::ActiveStorage::Attachment
        end

        def self.available_rest_actions
          super - %i[new create edit update]
        end

        private

        def resource_namespace
          :active_storage
        end

        def permitted_params
          params.require(:attachment).permit(:name, :record_type, :record_id, :blob)
        end
      end
    end
  end
end
