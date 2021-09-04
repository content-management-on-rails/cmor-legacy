module Cmor
  module Rbac
    module ResourcesPolicy
      class Base
        attr_reader :user, :record

        def initialize(user, record)
          @user = user
          @record = record
        end

        def index?
          # false
          authorize_with_rbac(user, record, __method__)
        end

        def show?
          # scope.where(id: record.id).exists?
          authorize_with_rbac(user, record, __method__)
        end

        def create?
          # false
          authorize_with_rbac(user, record, __method__)
        end

        def new?
          create?
        end

        def update?
          # false
          authorize_with_rbac(user, record, __method__)
        end

        def edit?
          update?
        end

        def destroy?
          # false
          authorize_with_rbac(user, record, __method__)
        end

        def scope
          Pundit.policy_scope!(user, record.class)
        end

        class Scope
          attr_reader :user, :scope

          def initialize(user, scope)
            @user = user
            @scope = scope
          end

          def resolve
            scope
          end
        end

        private

        def authorize_with_rbac(user, record, method_name)
          resource_name = record.class == Class ? record.name : record.class.name
          permission_identifier = "#{resource_name.underscore}/#{method_name.to_s.chomp('?')}"
          if Cmor::Rbac::Configuration.authorize_if_permission_is_missing
            return true if Cmor::Rbac::Permission.where(identifier: permission_identifier).none?
          end
          allowed = user.respond_to?(:allowed_to?) ? user.allowed_to?(permission_identifier) : true
        end
      end
    end
  end
end
