# require_dependency 'itsf_services'
require_dependency 'active_model/validations/file_readability_validator'

module Cmor
  module Rbac
    # Example:
    #
    #     # config/rbac.yml:
    #     defaults:
    #       permissions:
    #         - posts/index
    #         - posts/show
    #       roles:
    #         member:
    #           - posts/index
    #           - posts/show
    #
    #     # rails console:
    #     Cmor::Rbac::ImportDefaultPermissionsService.call
    #       =>
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Performing...
    #         [Cmor::Rbac::ImportDefaultPermissionsService]     Validating input...
    #         [Cmor::Rbac::ImportDefaultPermissionsService]       => Done
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Loaded YAML from /home/johndoe/rails_application/config/rbac.yml
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Checking for valid YAML structure
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Loaded 2 permissions
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Loaded 1 roles
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Saved 2 permissions
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Saved 1 roles
    #         [Cmor::Rbac::ImportDefaultPermissionsService]   Saved 2 role permissions
    #         [Cmor::Rbac::ImportDefaultPermissionsService]     => Done
    #
    class ImportDefaultPermissionsService < ApplicationService
      class Result < ApplicationService::Result
        attr_accessor :permissions, :roles, :role_permissions
      end

      attr_accessor :filename

      validates :filename, file_readability: true

      def _perform
        # say 'Validating input' do
        #   unless valid?
        #     say "Inputs are invalid. Errors: #{errors.full_messages.to_sentence}"
        #     say 'Aborted'
        #     return
        #   end
        # end

        return unless load_yaml
        return unless yaml_structure_valid?

        load_permissions
        load_roles

        @result.permissions = create_or_update_permissions
        @result.roles = create_or_update_roles
        @result.role_permissions = create_or_update_role_permissions
      end

      def filename
        @filename ||= Cmor::Rbac.default_permissions_filename.call
      end

      private

      def create_or_update_permissions
        permissions = @permissions.collect do |permission_identifier|
          Cmor::Rbac::Permission.where(identifier: permission_identifier).first_or_initialize.tap do |permission|
            permission.save!
          end
        end
        say "Saved #{permissions.count} permissions"
        permissions
      end

      def create_or_update_roles
        roles = @roles.collect do |role_identifier, permissions|
          Cmor::Rbac::Role.where(identifier: role_identifier).first_or_initialize.tap do |role|
            role.save!
          end
        end
        say "Saved #{roles.count} roles"
        roles
      end

      def create_or_update_role_permissions
        role_permissions = @roles.collect do |role_identifier, permissions|
          role = Cmor::Rbac::Role.where(identifier: role_identifier).first
          (permissions ||[]).collect do |permission_identifier|
            permission = Cmor::Rbac::Permission.where(identifier: permission_identifier).first

            Cmor::Rbac::RolePermission.where(role_id: role, permission_id: permission).first_or_initialize.tap do |role_permission|
              role_permission.save!
            end
          end
        end.flatten
        say "Saved #{role_permissions.count} role permissions"
        role_permissions
      end

      def load_permissions
        @permissions = @yaml[:defaults][:permissions] || []
        say "Loaded #{@permissions.size} permissions"
      end

      def load_roles
        @roles = @yaml[:defaults][:roles] || []
        say "Loaded #{@roles.size} roles"
      end

      def load_yaml
        yaml = YAML.load_file(filename)
        if yaml
          say "Loaded YAML from #{filename}"
          @yaml = yaml.with_indifferent_access
        else
          say "Could not load YAML from #{filename}"
          @yaml = yaml
        end
      end

      def yaml_structure_valid?
        say "Checking for valid YAML structure"
        unless @yaml.is_a?(Hash)
          add_error_and_say(:yaml_file, "Expected file content of #{filename} to parse to a Hash, but was #{@yaml.class}")
          return false
        end

        unless @yaml.has_key?(:defaults)
          add_error_and_say(:yaml_file, "Expected yaml in #{filename} to have the key [defaults:].")
          return false
        end

        unless @yaml[:defaults].has_key?(:roles)
          add_error_and_say(:yaml_file, "Expected yaml in #{filename} to have the key [defaults:][roles:].")
          return false
        end


        unless @yaml[:defaults].has_key?(:permissions)
          add_error_and_say(:yaml_file, "Expected yaml in #{filename} to have the key [defaults:][permissions:].")
          return false
        end

        return true
      end
    end
  end
end