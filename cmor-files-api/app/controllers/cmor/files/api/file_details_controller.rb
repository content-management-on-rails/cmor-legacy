module Cmor::Files::Api
  class FileDetailsController < Cmor::Files::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Files::FileDetail
    end

    def self.serializer_class
      Cmor::Files::Api::FileDetailSerializer
    end

    private

    def permitted_params
      params.require(:file_detail).permit(:folder_id, :asset, :title, :description)
    end
  end
end
