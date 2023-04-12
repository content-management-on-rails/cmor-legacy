module Cmor
  module UserArea
    module Frontend
      class TwoFactorAuthenticationSetupServicesController < TwoFactorAuthenticationSetupServices::BaseController
        def self.service_class
          Cmor::UserArea::TwoFactorAuthenticationSetupService
        end
      end
    end
  end
end
