module Cmor::Partners
  class CategoriesController < Cmor::Core::Backend::ResourcesController::Base
    include Rao::ResourcesController::ActsAsListConcern
    include Rao::ResourcesController::ActsAsPublishedConcern

    def self.resource_class
      Cmor::Partners::Category
    end

    private

    def permitted_params
      params.require(:category).permit(:locale, :identifier, :name, :body, :published)
    end
  end
end
