module Cmor
  module UserArea
    module Frontend
      class CurrentUsersController < Users::BaseController
        include Rao::ResourcesController::AasmConcern

        helper Rao::Component::ApplicationHelper

        def self.resource_class
          Cmor::UserArea::User
        end
      end
    end
  end
end
