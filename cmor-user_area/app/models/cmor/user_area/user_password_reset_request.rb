module Cmor
  module UserArea
    class UserPasswordResetRequest
      include ActiveModel::Model
      extend ActiveModel::Callbacks
      include ActiveModel::Validations::Callbacks

      attr_accessor :user, :email, :host

      def self.call(attributes)
        new(attributes).save
      end

      def self.i18n_scope
        :activerecord
      end

      validates :email, :host, presence: true
      validates :user, presence: true

      before_validation :load_user
      after_validation :delete_error_on_user, if: -> { errors.has_key?(:email) }

      def save
        return unless valid?
        user.reset_perishable_token
        user.save
        Cmor::UserArea::UserMailer.password_reset_email(user, host).deliver_later
      end

      private

      def load_user
        self.user = Cmor::UserArea::User.where(email: email).first
      end

      def delete_error_on_user
        errors.delete(:user)
      end
    end
  end
end
