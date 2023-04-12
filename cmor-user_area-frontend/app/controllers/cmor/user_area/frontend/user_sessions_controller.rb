module Cmor
  module UserArea
    module Frontend
      class UserSessionsController < Cmor::UserArea::Frontend::Sessions::BaseController
        def self.resource_class
          Cmor::UserArea::UserSession
        end
      end
    end
  end
end
