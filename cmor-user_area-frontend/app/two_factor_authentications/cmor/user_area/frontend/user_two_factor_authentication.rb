module Cmor
  module UserArea
    module Frontend
      class UserTwoFactorAuthentication < TwoFactorAuthentication::Base
        def self.user_class
          Cmor::UserArea::User
        end
      end
    end
  end
end
