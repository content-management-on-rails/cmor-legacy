module Cmor
  module Restaurant
    class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::AwesomeNestedSetConcern
      include Rao::ResourcesController::FriendlyIdConcern

      def self.resource_class
        Cmor::Restaurant::Category
      end

      private

      def after_reposition_location
        last_location
      end

      def resource_scope
        super.friendly
      end

      def permitted_params
        params.require(:category).permit(:description, :identifier, :locale, :name, :parent_id, :published)
      end
    end
  end
end
