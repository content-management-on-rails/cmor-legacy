module Cmor::Blog::Api
  class PostsController < Cmor::Blog::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Blog::Post
    end

    private

    def permitted_params
      params.require(:post).permit(:locale, :title, :body, :published, :tag_list, append_asset_detail_assets: [], overwrite_asset_detail_assets: [])
    end
  end
end
