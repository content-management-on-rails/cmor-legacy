module Cmor::Blog::Api
  class PostSerializer
    def initialize(resource)
      @resource = resource
    end

    def as_json
      @resource.as_json.merge(
        asset_url: Rails.application.routes.url_helpers.rails_blob_path(@resource.asset, only_path: true)
      )
    end
  end
end
