module Cmor::Blog::Api
  class PostsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::Post
    end

    def self.serializer_class
      Cmor::Blog::Api::PostSerializer
    end

    private

    def query_params_exceptions
      super + %w(populate)
    end

    def load_collection_scope
      super.includes(:asset_details, :tags)
    end

    def permitted_params
      params.require(:post).permit(:locale, :title, :body, :published, :tag_list, append_asset_detail_assets: [], overwrite_asset_detail_assets: [])
    end
  end
end
