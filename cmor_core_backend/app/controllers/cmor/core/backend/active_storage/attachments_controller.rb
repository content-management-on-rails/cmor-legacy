module Cmor
  module Core
    module Backend
      module ActiveStorage
        class AttachmentsController < Cmor::Core::Backend::ResourcesController::Base
          def self.resource_class
            ::ActiveStorage::Attachment
          end

          private

          def permitted_params
            params.require(:attachment).permit()
          end
        end
      end
    end
  end
end