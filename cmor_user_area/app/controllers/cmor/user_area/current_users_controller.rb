module Cmor
  module UserArea
    class CurrentUsersController < Users::BaseController
      helper Rao::Component::ApplicationHelper

      def self.resource_class
        Cmor::UserArea::User
      end
    end
  end
end