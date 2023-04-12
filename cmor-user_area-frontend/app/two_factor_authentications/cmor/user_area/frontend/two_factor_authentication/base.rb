module Cmor
  module UserArea
    module Frontend
      module TwoFactorAuthentication
        class Base < Rao::Service::Base
          class Result < Rao::Service::Result::Base
          end

          attr_accessor :authenticable, :code

          validates :authenticable, :code, presence: true

          def self.user_class
            raise "not implemented"
          end

          private

          def _perform
            if @authenticable.authenticate_otp(code)
              nil
            else
              @errors.add(:code, t(".invalid_code"))
            end
          end
        end
      end
    end
  end
end
