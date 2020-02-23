module Cmor::Files
  class FileDetailsController < ApplicationResourcesController
    include Rao::ResourcesController::FriendlyIdConcern

    helper Rao::Component::ApplicationHelper

    def self.resource_class
      Cmor::Files::FileDetail
    end

    private

    def load_collection_scope
      super.published
    end

    def load_resource_scope
      super.published
    end
  end
end
