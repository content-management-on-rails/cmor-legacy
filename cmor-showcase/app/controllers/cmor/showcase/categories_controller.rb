module Cmor::Showcase
  class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern
    include Rao::ResourcesController::FriendlyIdConcern

    def self.resource_class
      Cmor::Showcase::Category
    end

    private

    def permitted_params
      params.require(:category).permit(:locale, :identifier, :name, :body, :published, :image)
    end
  end
end
