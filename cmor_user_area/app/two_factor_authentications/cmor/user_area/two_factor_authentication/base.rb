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
          # The 2fa code is correct we return without errors
          return if code == @authenticable.otp_code

          # The 2fa code was not correct. We try recovery codes
          if @authenticable.otp_backup_codes.include?(code)
            # We found the code in the recovery codes so we remove it and return without errors
            @authenticable.otp_backup_codes = @authenticable.otp_backup_codes - [code]
            @authenticable.save!
            return
          end

          # Authentication failed as the entered code didn't match the otp_code
          # or any backup code.
          @errors.add(:code, t(".invalid_code"))
        end
      end
    end
  end
end