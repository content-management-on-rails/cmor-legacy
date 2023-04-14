module Cmor
  module UserArea
    class CreateDefaultUserService < ::Cmor::UserArea::ApplicationService
      class Result < ::Cmor::UserArea::ApplicationService::Result
        attr_accessor :user, :email, :password, :password_confirmation, :active, :approved, :confirmed
      end

      attr_accessor :email, :password, :password_confirmation, :active, :approved, :confirmed

      validates :password, confirmation: true, allow_blank: true

      def _perform
        @result.user = create_user
      end

      private

      def after_initialize
        user_attribute_defaults.each do |key, value|
          send(key) || send("#{key}=", value)
        end
      end

      def create_user
        user = Cmor::UserArea::User.new(user_attributes)
        say "Creating user [#{user.email}]" do
          if user.save
            say "=> [OK]"
          else
            add_error_and_say(:base, "=> [FAILED] Errors: #{user.errors.full_messages.to_sentence}")
          end
          user
        end
      end

      def user_attributes
        {email: email, password: password, password_confirmation: password_confirmation, active: ActiveModel::Type::Boolean.new.cast(active), approved: ActiveModel::Type::Boolean.new.cast(approved), confirmed: ActiveModel::Type::Boolean.new.cast(confirmed)}.compact.delete_if { |k, v| v.blank? }
      end

      def user_attribute_defaults
        {
          email: "user@example.com",
          password: "password",
          password_confirmation: "password",
          active: true,
          approved: true,
          confirmed: true
        }
      end
    end
  end
end
