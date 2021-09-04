module Cmor
  module Rbac
    module ResourcesController
      module PunditConcern
        extend ActiveSupport::Concern

        included do
          include Pundit
          before_action :authorize_index, only: [:index]
          before_action :authorize_show , only: [:show]
          before_action :authorize_create , only: [:create]
          before_action :authorize_new , only: [:new]
          before_action :authorize_update , only: [:update]
          before_action :authorize_edit , only: [:edit]
          before_action :authorize_destroy , only: [:destroy]

          rescue_from Pundit::NotAuthorizedError, with: :handle_not_authorized
        end

        private

        def handle_not_authorized(exception)
          resource_name   = exception.record.respond_to?(:model_name) ? exception.record.model_name.human : exception.record
          collection_name = exception.record.respond_to?(:model_name) ? exception.record.model_name.human(count: :other) : exception.record

          permission_basename = (exception.record.class == Class ? exception.record.name : exception.record.class.name).underscore
          method_name = exception.query.to_s.chomp('?')
          permission_identifier = [permission_basename, method_name].join("/")

          flash[:error] = I18n.t("pundit.not_authorized.resources_controller.#{action_name}", collection_name: collection_name, resource_name: resource_name, permission_identifier: permission_identifier)
          respond_to do |format|
            format.html { redirect_to(authorization_failed_location) }
            format.json { render json: { error: 'not authorized' }, status: 403 }
          end
        end

        def authorization_failed_location
          instance_exec(&Cmor::Rbac::Configuration.authorization_failed_location)
        end

        def authorize_index
          authorize(resource_class)
        end

        def authorize_show
          authorize(@resource, :show?)
        end

        def authorize_create
          authorize(@resource, :create?)
        end

        def authorize_new
          authorize(@resource, :new?)
        end

        def authorize_update
          authorize(@resource, :update?)
        end

        def authorize_edit
          authorize(@resource, :edit?)
        end

        def authorize_destroy
          authorize(@resource, :destroy?)
        end
      end
    end
  end
end
