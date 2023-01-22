module Cmor::Seo::Api
  class MetaTagsController < Cmor::Seo::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Seo::MetaTag
    end

    def self.serializer_class
      Cmor::Seo::Api::MetaTagSerializer
    end

    private

    def permitted_params
      params.require(:meta_tag).permit(:item_id, :name, :content, :published)
    end
  end
end
