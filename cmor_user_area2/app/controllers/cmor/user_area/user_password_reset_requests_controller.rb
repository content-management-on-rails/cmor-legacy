module Cmor
  module UserArea
    class UserPasswordResetRequestsController < PasswordResetRequests::BaseController
      def self.resource_class
        Cmor::UserArea::UserPasswordResetRequest
      end

      private

      def after_create_location
        new_user_session_path
      end
    end
  end
end