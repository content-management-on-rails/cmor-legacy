module Cmor
  module UserArea
    class CreateDefaultUserService < ::Cmor::UserArea::ApplicationService
      class Result < ::Cmor::UserArea::ApplicationService::Result
        attr_accessor :user
      end

      def _perform
        @result.user = create_default_user
      end

      private

      def create_default_user
        user = Cmor::UserArea::User.new(user_attributes)
        if user.save
          say 'Created default user'
        else
          add_error_and_say(:base, "Could not create default user. Errors: #{user.errors.full_messages.to_sentence}")
        end
        user
      end

      def user_attributes
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