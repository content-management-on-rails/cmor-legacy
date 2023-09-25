module Cmor::Galleries::Api
  class PictureDetailSerializer < Cmor::Core::Api::Serializer::Base
    def as_json
      super.tap do |result|
        result[:attributes][:asset_url] = asset_url
        result
      end
    end

    def asset_url
      return nil unless @resource.asset.attached?
      Rails.application.routes.url_helpers.rails_blob_url(@resource.asset, default_url_options)
    end
  end
end
