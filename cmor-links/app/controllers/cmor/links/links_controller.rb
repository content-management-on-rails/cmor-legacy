module Cmor
  module Links
    class LinksController < Cmor::Core::Backend::ResourcesController::Base
      def self.resource_class
        Cmor::Links::Link
      end

      private

      def load_collection_scope
        super.includes(:category)
      end

      def permitted_params
        params
          .require(:link)
          .permit(:category_id, :name, :url, :description)
      end
    end
  end
end
