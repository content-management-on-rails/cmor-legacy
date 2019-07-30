module Cmor::Showcase
  class ItemsController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Showcase::Item
    end

    private

    def permitted_params
      params.require(:item).permit(:category_id, :identifier, :name, :body, :published, assets: [])
    end
  end
end