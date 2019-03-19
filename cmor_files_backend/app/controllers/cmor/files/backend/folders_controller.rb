module Cmor
  module Files
    module Backend
      class FoldersController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsPublishedConcern

        def self.resource_class
          Cmor::Files::Folder
        end

        private

        def permitted_params
          params.require(:folder).permit(:name, :description, :published, assets: [], append_assets: [], overwrite_assets: [])
        end
      end
    end
  end
end
