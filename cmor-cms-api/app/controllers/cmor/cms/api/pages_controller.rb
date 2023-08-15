module Cmor::Cms::Api
  class PagesController < Cmor::Cms::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Cms::Page
    end

    def self.serializer_class
      Cmor::Cms::Api::PageSerializer
    end

    private

    def permitted_params
      params
        .require(:page)
        .permit(:title, :meta_description, :body, :pathname, :basename, :locale, :format, :handler, :layout, :published, navigation_item_ids: [])
    end
  end
end
