module Cmor::Blog::Api
  class AssetDetailsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::AssetDetail
    end

    def self.serializer_class
      Cmor::Blog::Api::PostSerializer
    end
  end
end
