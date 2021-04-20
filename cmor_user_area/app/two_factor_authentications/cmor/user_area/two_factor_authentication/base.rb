module Cmor
  module UserArea
    module TwoFactorAuthentication
      class Base < Rao::Service::Base
        class Result < Rao::Service::Result::Base
        end

        attr_accessor :code

        attr_accessor :authenticable, :code

        validates :authenticable, :code, presence: true

        private

        def _perform
          if @authenticable.authenticate_otp(code)
            return
          else
            @errors.add(:code, t(".invalid_code"))
          end
        end
      end
    end
  end
end
