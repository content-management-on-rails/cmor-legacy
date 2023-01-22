module Cmor::Seo::Api
  class ItemsController < Cmor::Seo::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Seo::Item
    end

    def self.serializer_class
      Cmor::Seo::Api::ItemSerializer
    end

    private

    def permitted_params
      params.require(:item).permit(:resource_type, :resource_id, :path, :published, :title, meta_tags_attributes: [:id, :name, :content, :published, :_destroy])
    end
  end
end
