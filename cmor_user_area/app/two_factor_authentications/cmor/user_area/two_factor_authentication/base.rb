module Cmor
  module UserArea
    module TwoFactorAuthentication
      class Base < Rao::Service::Base
        class Result < Rao::Service::Result::Base
        end

        attr_accessor :code

        attr_accessor :authenticable, :code

        validates :authenticable, :code, presence: true
  
        validates :code, confirmation: true
  
        def code_confirmation
          @authenticable.otp_code
        end

        private

        def _perform
        end
      end
    end
  end
end