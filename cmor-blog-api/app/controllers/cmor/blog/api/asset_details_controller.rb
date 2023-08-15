module Cmor::Blog::Api
  class AssetDetailsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::AssetDetail
    end

    def self.serializer_class
      Cmor::Blog::Api::AssetDetailSerializer
    end

    private

    def permitted_params
      params.require(:asset_detail).permit(:post_id, :title, :description, :published, :asset)
    end
  end
end
