module Cmor::Partners
  class PartnersController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern
    helper Twitter::Bootstrap::Components::Rails::V4::ComponentsHelper

    def self.resource_class
      Cmor::Partners::Partner
    end

    def load_collection_scope
      super.includes(:category)
    end

    private

    def permitted_params
      params.require(:partner).permit(:category_id, :identifier, :name, :body, :published, :logo)
    end
  end
end
