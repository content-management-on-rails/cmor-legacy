module Cmor
  module UserArea
    module Frontend
      class UserPasswordResetRequestsController < PasswordResetRequests::BaseController
        def self.resource_class
          Cmor::UserArea::Frontend::UserPasswordResetRequest
        end

        private

        def after_create_location
          # new_user_session_path
          url_for([:new, Cmor::UserArea::UserSession])
        end
      end
    end
  end
end
