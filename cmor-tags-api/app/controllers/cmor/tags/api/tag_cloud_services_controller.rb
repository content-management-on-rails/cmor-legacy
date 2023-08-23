module Cmor
  module Tags
    module Api
      class TagCloudServicesController < Cmor::Tags::Api::Configuration.base_controller.constantize
        include Rao::Api::ServiceController::ServiceConcern
        include Rao::Api::ServiceController::RestActionsConcern
        include Cmor::Core::Api::ServiceController::SerializationConcern
        
        def self.service_class
          Cmor::Tags::TagCloudService
        end

        def self.serializer_class
          Cmor::Tags::Api::TagCloudServiceSerializer
        end

        private

        def permitted_params
          params.fetch(:tag_cloud, {}).permit(:limit)
        end
      end
    end
  end
end
