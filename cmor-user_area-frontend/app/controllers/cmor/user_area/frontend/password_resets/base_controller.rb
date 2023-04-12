module Cmor
  module UserArea
    module Frontend
      module PasswordResets
        class BaseController < Cmor::UserArea::Frontend::Configuration.base_controller.constantize
          include Rao::ResourcesController::ResourcesConcern
          include Rao::ResourcesController::ResourceInflectionsConcern
          include Rao::ResourcesController::RestResourceUrlsConcern
          include Rao::ResourcesController::RestActionsConcern
          include Controller::RedirectBackConcern

          if Rails.version < "5"
            skip_before_action :authenticate_user!
          else
            skip_before_action :authenticate_user!, raise: false
          end

          before_action :find_using_perishable_token

          private

          # def load_resource
          #   @resource
          # end

          def load_resource
            User.find_using_perishable_token(params[:token])
          end

          def permitted_params
            params.require(:user).permit(:password, :password_confirmation)
          end

          def after_update_location
            new_user_session_path
          end

          def handle_user_not_found
            redirect_to new_user_session_path, notice: t("messages.failures.cmor_user_area_frontend.perishable_token_invalid")
          end

          def find_using_perishable_token
            @resource = User.find_using_perishable_token(params[:token])
            handle_user_not_found if @resource.nil?
          end
        end
      end
    end
  end
end
