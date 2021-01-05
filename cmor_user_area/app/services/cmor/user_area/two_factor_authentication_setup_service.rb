module Cmor
  module UserArea
    class TwoFactorAuthenticationSetupService < Rao::Service::Base
      class Result < Rao::Service::Result::Base
      end

      attr_accessor :user, :code

      validates :user, :code, presence: true

      validates :code, confirmation: true

      def code_confirmation
        @user.otp_code
      end

      def qr_code
        @qr_code ||= RQRCode::QRCode.new(@user.provisioning_uri(nil, issuer: issuer))
      end

      def prepare_tfa!
        @user.prepare_tfa!
      end

      def backup_codes
        @user.otp_backup_codes
      end

      private

      def after_initialize
        prepare_tfa!
      end

      def _perform
        @user.enable_tfa!
      end

      def issuer
        "#{Rails.application.class.name.deconstantize} (#{Rails.env})"
      end
    end
  end
end
