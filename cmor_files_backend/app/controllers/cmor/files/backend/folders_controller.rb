module Cmor
  module Files
    module Backend
      class FoldersController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::ActsAsListConcern
        include Rao::ResourcesController::ActsAsPublishedConcern
        include Rao::ResourcesController::FriendlyIdConcern

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
