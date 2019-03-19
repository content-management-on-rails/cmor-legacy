module Cmor
  module UserArea
    class UserPasswordResetsController < PasswordResets::BaseController
      def self.resource_class
        Cmor::UserArea::User
      end
    end
  end
end