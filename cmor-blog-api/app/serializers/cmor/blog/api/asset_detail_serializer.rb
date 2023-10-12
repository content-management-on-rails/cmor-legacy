module Cmor::Blog::Api
  class AssetDetailSerializer < Cmor::Core::Api::Serializer::Base
    def as_json
      super.tap do |hash|
        hash[:attributes].merge!(asset_url: asset_url)
      end
    end

    private

    def asset_url
      return nil if @resource.asset.blank?
      Rails.application.routes.url_helpers.rails_service_blob_path(@resource.asset.blob, signed_id: @resource.asset.blob.signed_id, filename: @resource.asset.blob.filename.to_s, only_path: true)
    end
  end
end
