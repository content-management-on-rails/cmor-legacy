module Cmor::Files::Api
  class FoldersController < Cmor::Files::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Files::Folder
    end

    def self.serializer_class
      Cmor::Files::Api::FolderSerializer
    end
  end
end
