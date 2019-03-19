module Model
  module Cmor
    module Rbac
      module UserConcern
        extend ActiveSupport::Concern

        included do
          # associations
          has_many :user_roles, class_name: 'Cmor::Rbac::UserRole', inverse_of: :user, dependent: :destroy
          has_many :roles, class_name: 'Cmor::Rbac::Role', through: :user_roles
          has_many :role_permissions, class_name: 'Cmor::Rbac::RolePermission', through: :roles
          has_many :permissions, through: :role_permissions, class_name: 'Cmor::Rbac::Permission'

          has_many :enabled_roles, -> { enabled }, class_name: 'Cmor::Rbac::Role', through: :user_roles # , source: :user
          has_many :enabled_role_permissions, class_name: 'Cmor::Rbac::RolePermission', through: :enabled_roles, source: :user_roles
          
          has_many :enabled_permissions, through: :enabled_role_permissions, class_name: 'Cmor::Rbac::Permission', source: :permission
        end

        def allowed_to?(permission_identifier)
          enabled_permissions.map(&:identifier).map(&:to_sym).include?(permission_identifier.to_sym)
        end

        def has_role?(role_identifier)
          enabled_roles.map(&:identifier).map(&:to_sym).include?(role_identifier.to_sym)
        end

        def add_role(role_identifier)
          role = ::Cmor::Rbac::Role.where(identifier: role_identifier).first
          if role
            roles << role
          else
            false
          end
        end

        def roles_count
          roles.count
        end

        def enabled_roles_count
          enabled_roles.count
        end

        def permissions_count
          permissions.count
        end

        def enabled_permissions_count
          enabled_permissions.count
        end
      end
    end
  end
end
