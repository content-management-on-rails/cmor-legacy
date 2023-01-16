module Cmor::Carousels
  class ItemDetailsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Carousels::ItemDetail
    end

    def self.available_rest_actions
      super - %i(new create)
    end

    private

    def after_reposition_location
      last_location
    end

    def after_destroy_many_location
      last_location
    end

    def load_collection_scope
      super.eager_load(:carousel)
    end

    def permitted_params
      params.require(:item_detail).permit(:carousel_id, :url, :description, :published, :asset)
    end
  end
end
