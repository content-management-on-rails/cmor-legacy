module Cmor::Files
  class AttachmentsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::SortingConcern
    include Rao::ResourcesController::BatchActionsConcern

    def self.resource_class
      ActiveStorage::Attachment
    end

    private

    def after_destroy_many_location
      last_location
    end

    def permitted_params
      params.require(:attachment).permit
    end
  end
end
