module Cmor::Showcase::Api
  class ItemsController < Cmor::Showcase::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Showcase::Item
    end

    def self.serializer_class
      Cmor::Showcase::Api::ItemSerializer
    end

    private

    def permitted_params
      params.require(:item).permit(:category_id, :identifier, :name, :body, :published, append_file_detail_assets: [], overwrite_file_detail_assets: [])
    end
  end
end
