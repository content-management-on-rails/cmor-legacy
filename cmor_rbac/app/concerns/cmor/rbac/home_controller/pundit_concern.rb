module Cmor
  module Rbac
    module HomeController
      module PunditConcern
        extend ActiveSupport::Concern

        included do
          include Pundit
          before_action :authorize_action
          after_action :verify_authorized

          rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized
        end

        private

        def handle_not_authorized(exception)
          permission_basename = self.class.name.gsub('Controller', '').underscore
          method_name = exception.query.to_s.chomp('?')
          permission_identifier = [permission_basename, method_name].join("/")

          flash[:error] = t("permission_missing", scope: "pundit", permission_identifier: permission_identifier)

          respond_to do |format|
            format.html { redirect_to(authorization_failed_location) }
            format.json { render json: { error: 'not authorized' }, status: 403 }
          end
        end

        def authorization_failed_location
          instance_exec(&Cmor::Rbac::Configuration.authorization_failed_location)
        end

        def authorize_action
          authorize(self.class, "#{action_name}?".to_sym)
        end
      end
    end
  end
end
