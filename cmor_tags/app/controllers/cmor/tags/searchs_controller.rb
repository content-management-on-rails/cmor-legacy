module Cmor
  module Tags
    class SearchsController < Cmor::Tags::Configuration.base_controller.constantize
      include Rao::ServiceController::ServiceConcern
      include Rao::ServiceController::RestActionsConcern
      include Rao::ServiceController::RestServiceUrlsConcern
      include Rao::ServiceController::ServiceInflectionsConcern
      include Rao::ServiceController::LocationHistoryConcern

      helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper
      
      def self.service_class
        Cmor::Tags::Search
      end

      private

      def permitted_params
        return {tag_list: params[:tag_list] } if params.has_key?(:tag_list)
        params.require(:search).permit(:tag_list, :taggable_classes, :exact)
      end
    end
  end
end
