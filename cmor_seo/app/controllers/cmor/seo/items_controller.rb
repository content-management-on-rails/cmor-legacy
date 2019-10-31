module Cmor::Seo
  class ItemsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern
    include Rao::ResourcesController::FriendlyIdConcern

    def self.resource_class
      Cmor::Seo::Item
    end

    private

    def after_reposition_location
      last_location # collection_path
    end

    def load_collection_scope
      super.includes(:category)
    end

    def permitted_params
      params.require(:item).permit(:category_id, :identifier, :name, :body, :published, assets: [], append_assets: [], overwrite_assets: [])
    end
  end
end