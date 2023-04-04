module Cmor
  module Restaurant
    class AllergensController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsListConcern
      include Rao::ResourcesController::FriendlyIdConcern

      def self.resource_class
        Cmor::Restaurant::Allergen
      end

      private

      def after_reposition_location
        last_location
      end

      def resource_scope
        super.friendly
      end

      def permitted_params
        params.require(:allergen).permit(:name, :description, :published, :identifier)
      end
    end
  end
end
