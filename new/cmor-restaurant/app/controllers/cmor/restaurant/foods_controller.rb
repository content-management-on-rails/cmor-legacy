module Cmor
  module Restaurant
    class FoodsController < Cmor::Core::Backend::ResourcesController::Base
      include Rao::ResourcesController::ActsAsListConcern
      include Rao::ResourcesController::FriendlyIdConcern

      def self.resource_class
        Cmor::Restaurant::Food
      end

      private

      def after_reposition_location
        last_location
      end

      def resource_scope
        super.friendly
      end

      def permitted_params
        params.require(:food).permit(:name, :description, :price, :unit, :category_id, :published, :identifier, :quantity)
      end
    end
  end
end
