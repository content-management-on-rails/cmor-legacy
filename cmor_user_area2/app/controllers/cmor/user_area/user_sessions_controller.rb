module Cmor
  module UserArea
    class UserSessionsController < Cmor::UserArea::Sessions::BaseController
      def self.resource_class
        Cmor::UserArea::UserSession
      end
    end
  end
end