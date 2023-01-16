module Cmor::Showcase
  class FileDetailsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::SortingConcern
    include Rao::ResourcesController::BatchActionsConcern

    def self.resource_class
      Cmor::Showcase::FileDetail
    end

    def self.available_rest_actions
      super - %i[new]
    end

    private

    def after_reposition_location
      last_location
    end

    def after_destroy_many_location
      last_location
    end

    def permitted_params
      params.require(:file_detail).permit(:title, :description)
    end
  end
end
