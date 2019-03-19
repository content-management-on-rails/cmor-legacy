module Cmor
  module Files
    module Backend
      class FileDetailsController < Cmor::Core::Backend::ResourcesController::Base
        include Rao::ResourcesController::SortingConcern

        helper Twitter::Bootstrap::Components::Rails::V3::ComponentsHelper

        def self.resource_class
          Cmor::Files::FileDetail
        end

        private

        def permitted_params
          params.require(:file_detail).permit(:title, :description)
        end
      end
    end
  end
end
