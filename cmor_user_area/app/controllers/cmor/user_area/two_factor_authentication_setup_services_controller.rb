module Cmor
  module UserArea
    class TwoFactorAuthenticationSetupServicesController < TwoFactorAuthenticationSetupServices::BaseController
      def self.service_class
        Cmor::UserArea::TwoFactorAuthenticationSetupService
      end
    end
  end
end
