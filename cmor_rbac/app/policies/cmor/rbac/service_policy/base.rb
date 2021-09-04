module Cmor
  module Rbac
    module ServicePolicy
      class Base
        attr_reader :user, :service

        def initialize(user, service)
          @user = user
          @service = service
        end

        def new?
          authorize_with_rbac(user, service, __method__)
        end

        def create?
          authorize_with_rbac(user, service, __method__)
        end

        private

        def authorize_with_rbac(user, service_class, method_name)
          permission_identifier = "#{service_class.name.underscore}/#{method_name.to_s.chomp('?')}"
          if Cmor::Rbac::Configuration.authorize_if_permission_is_missing
            return true if Cmor::Rbac::Permission.where(identifier: permission_identifier).none?
          end
          user.respond_to?(:allowed_to?) ? user.allowed_to?(permission_identifier) : true
        end
      end
    end
  end
end
