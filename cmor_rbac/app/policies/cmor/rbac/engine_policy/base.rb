module Cmor
  module Rbac
    module EnginePolicy
      class Base < Struct.new(:user, :engine)
        def access?
          authorize_with_rbac(user, __method__)
        end

        private

        def authorize_with_rbac(user, method_name)
          permission_identifier = "#{self.class.name.underscore.chomp("_policy")}/#{method_name.to_s.chomp('?')}"
          if Cmor::Rbac::Configuration.authorize_if_permission_is_missing
            return true if Cmor::Rbac::Permission.where(identifier: permission_identifier).none?
          end
          user.respond_to?(:allowed_to?) ? user.allowed_to?(permission_identifier) : true
        end
#        def access?
#          permission_identifier = self.class.name.gsub('Policy', '').underscore
#          allowed = user.respond_to?(:allowed_to?) ? user.allowed_to?(permission_identifier) : false
#
#          user_label = Administrador::ApplicationViewHelper.new(self).label_for(user)
#
#          if allowed
#            Rails.logger.debug "User #{user_label} is allowed to access #{permission_identifier}"
#          else
#            Rails.logger.debug "User #{user_label} is not allowed to access #{permission_identifier}"
#          end
#          allowed
#        end
      end
    end
  end
end
