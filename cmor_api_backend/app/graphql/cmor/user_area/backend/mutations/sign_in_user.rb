module Cmor
  module UserArea
    module Backend
      module Mutations
        # @todo https://www.howtographql.com/graphql-ruby/4-authentication/
        #
        # mutation {
        #   signInUser(email: "user@example.com", password: "password") {
        #     auth {
        #       token
        #     }
        #   }
        # }
        #
        class SignInUser < Cmor::Api::Mutations::Base
          # graphql_name 'SignIn'
          argument :email, String, required: true
          argument :password, String, required: true

          field :auth, Cmor::UserArea::Backend::Types::AuthType, null: false

          def resolve(email:, password:)
            user = Cmor::UserArea::User.authenticable.where(email: email).first
            if user
              if user.valid_password?(password)
                ensure_single_access_token!(user)
                { auth: { token: user.single_access_token } }
              else
                GraphQL::ExecutionError.new('Incorrect Email/Password')
              end
            else
              GraphQL::ExecutionError.new('User not registered on this application')
            end
          end

          private

          def ensure_single_access_token!(user)
            if user.single_access_token.nil?
              user.single_access_token = Authlogic::Random.friendly_token
              user.save!
            end
          end
        end
      end
    end
  end
end
