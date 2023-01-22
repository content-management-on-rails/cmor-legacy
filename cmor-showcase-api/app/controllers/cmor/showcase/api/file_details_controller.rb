module Cmor::Showcase::Api
  class FileDetailsController < Cmor::Showcase::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Showcase::FileDetail
    end

    def self.serializer_class
      Cmor::Showcase::Api::FileDetailSerializer
    end

    private

    def permitted_params
      params.require(:file_detail).permit(:asset, :item_id, :title, :description)
    end
  end
end
