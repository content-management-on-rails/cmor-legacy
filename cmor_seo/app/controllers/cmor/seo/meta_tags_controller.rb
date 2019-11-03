module Cmor::Seo
  class MetaTagsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Seo::MetaTag
    end

    private

    def load_collection_scope
      super.includes(:item)
    end

    def after_reposition_location
      last_location
    end

    def permitted_params
      params.require(:meta_tag).permit(:item_id, :name, :content, :published)
    end
  end
end