module Cmor::Partners::Frontend
  class PartnersController < Cmor::Partners::Frontend::Configuration.base_controller.constantize
    include Rao::ResourcesController::RestActionsConcern
    include Rao::ResourcesController::ResourcesConcern
    include Rao::ResourcesController::RestResourceUrlsConcern
    include Rao::ResourcesController::ResourceInflectionsConcern

    def self.resource_class
      Cmor::Partners::Partner
    end

    private

    def permitted_params
      params.require(:category).permit()
    end
  end
end