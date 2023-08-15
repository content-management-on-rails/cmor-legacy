module Cmor::Blog::Api
  class AssetDetailSerializer
    def initialize(resource, params = {})
      @resource = resource
      @params = params
    end

    def as_json
      @resource.as_json(include: (@params[:populate] || [])).merge(asset_url: asset_url)
    end

    private

    def asset_url
      return nil if @resource.asset.blank?
      Rails.application.routes.url_helpers.rails_service_blob_path(@resource.asset.blob, signed_id: @resource.asset.blob.signed_id, filename: @resource.asset.blob.filename.to_s, only_path: true)
    end
  end
end
