module Cmor::Showcase::Frontend
  class ItemsController < Cmor::Showcase::Frontend::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern
    include Rao::ResourcesController::FriendlyIdConcern

    view_helper Markup::Rails::ApplicationViewHelper, as: :markup_helper

    helper Rao::Component::ApplicationHelper

    def self.resource_class
      Cmor::Showcase::Item
    end

    private

    def permitted_params
      params.require(:item).permit()
    end
  end
end