module Cmor
  module UserArea
    module PasswordResetRequests
      class BaseController < Cmor::UserArea::Configuration.base_controller.constantize
        include Rao::ResourcesController::ResourcesConcern
        include Rao::ResourcesController::ResourceInflectionsConcern
        include Rao::ResourcesController::RestResourceUrlsConcern
        include Rao::ResourcesController::RestActionsConcern
        include Controller::RedirectBackConcern

        skip_before_action :authenticate_user!, raise: false

        def create
          @resource = resource_class.new(permitted_params)
          @resource.host = request.host
          @resource.save
          respond_with @resource, location: after_create_location
        end

        def edit
          @resource = load_user_by_token
          unless @resource
            flash[:error] = t('.user_not_found')
            redirect_to new_user_session_path
            return
          end
          respond_with @resource
        end


        private

        def load_user_by_token
          User.find_using_perishable_token(params[:token])
        end


        def permitted_params
          params.require(resource_class.name.demodulize.underscore.to_sym).permit(:email)
        end
      end
    end
  end
end