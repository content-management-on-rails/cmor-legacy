module Cmor
  module UserArea
    module Frontend
      class UserTwoFactorAuthenticationsController < Cmor::UserArea::Frontend::TwoFactorAuthentications::BaseController
        def self.service_class
          Cmor::UserArea::Frontend::UserTwoFactorAuthentication
        end
      end
    end
  end
end
