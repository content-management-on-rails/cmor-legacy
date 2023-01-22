module Cmor::Blog::Api
  class AssetDetailsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::AssetDetail
    end

    def self.serializer_class
      Cmor::Blog::Api::PostSerializer
    end

    private

    def permitted_params
      params.require(:asset_detail).permit(:title, :description, :published)
    end
  end
end
