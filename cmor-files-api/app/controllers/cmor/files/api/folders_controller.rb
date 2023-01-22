module Cmor::Files::Api
  class FoldersController < Cmor::Files::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Files::Folder
    end

    def self.serializer_class
      Cmor::Files::Api::FolderSerializer
    end

    private

    def permitted_params
      params.require(:folder).permit(:name, :description, :identifier, :published, append_file_detail_assets: [], overwrite_file_detail_assets: [])
    end
  end
end
