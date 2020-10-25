module Cmor
  module UserArea
    class UserTwoFactorAuthenticationsController < Cmor::UserArea::TwoFactorAuthentications::BaseController
      def self.service_class
        Cmor::UserArea::UserTwoFactorAuthentication
      end
    end
  end
end