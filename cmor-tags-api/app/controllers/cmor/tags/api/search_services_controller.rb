module Cmor
  module Tags
    module Api
      class SearchServicesController < Cmor::Tags::Api::Configuration.base_controller.constantize
        include Rao::Api::ServiceController::ServiceConcern
        include Rao::Api::ServiceController::RestActionsConcern
        include Cmor::Core::Api::ServiceController::SerializationConcern
        
        def self.service_class
          Cmor::Tags::SearchService
        end

        def self.serializer_class
          Cmor::Tags::Api::SearchServiceSerializer
        end

        private

        def permitted_params
          return {tag_list: params[:tag_list] } if params.has_key?(:tag_list)
          params.require(:search).permit(:tag_list, :taggable_classes, :exact)
        end
      end
    end
  end
end
