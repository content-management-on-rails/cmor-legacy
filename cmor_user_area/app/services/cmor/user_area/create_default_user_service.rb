module Cmor
  module UserArea
    class CreateDefaultUserService < ::Cmor::UserArea::ApplicationService
      class Result < ::Cmor::UserArea::ApplicationService::Result
        attr_accessor :user, :email, :password, :password_confirmation, :active, :approved, :confirmed
      end

      attr_accessor :email, :password, :password_confirmation, :active, :approved, :confirmed

      def _perform
        @result.user = create_user
      end

      private

      def create_user
        user = Cmor::UserArea::User.new(user_attributes)
        say "Creating user [#{user.email}]" do
          if user.save
            say '=> [OK]'
          else
            add_error_and_say(:base, "=> [FAILED] Errors: #{user.errors.full_messages.to_sentence}")
          end
          user
        end
      end

      def user_attributes
        user_attribute_defaults.merge(user_attribute_overrides)
      end

      def user_attribute_overrides
        { email: email, password: password, password_confirmation: password_confirmation, active: active, approved: approved, confirmed: confirmed }.compact
      end

      def user_attribute_defaults
        {
          email: 'user@example.com',
          password: 'password',
          password_confirmation: 'password',
          active: true,
          approved: true,
          confirmed: true
        }
      end
    end
  end
end