module Cmor
  module UserArea
    module Frontend
      module Controller
        # Example:
        #
        #     # app/controllers/application_controller.rb
        #     class ApplicationController < ActionController::Base
        #       include Cmor::UserArea::Frontend::Controller::CurrentUserConcern
        #     end
        #
        module CurrentUserConcern
          extend ActiveSupport::Concern

          included do
            helper_method :current_user_session, :current_user, :user_signed_in?
          end

          private

          def after_sign_out_url
            Cmor::UserArea::Frontend::Configuration.after_sign_out_url
          end

          def authenticate_user!
            unless user_signed_in?
              store_location
              handle_authentication_failure
              return false
            end
            true
          end

          def current_user_session
            return @current_user_session if defined?(@current_user_session)
            @current_user_session = ::Cmor::UserArea::UserSession.find
          end

          def current_user
            return @current_user if defined?(@current_user)
            @current_user = current_user_session&.user
          end

          def user_authentication_failed_path
            cmor_user_area_frontend.new_user_session_path
          end

          def user_signed_in?
            !current_user.nil?
          end

          def sign_out_user
            @current_user = nil
            redirect_to after_sign_out_url
          end

          def current_session(type)
            type = type.to_s
            type << "_session" unless type.end_with?("_session")
            send("current_#{type}".to_sym)
          end

          def handle_authentication_failure
            respond_to do |format|
              format.json { render json: {error: :forbidden}, status: :forbidden }
              format.html { redirect_to(user_authentication_failed_path, notice: t("messages.failures.cmor_user_area_frontend.authentication_failed")) }
            end
          end
        end
      end
    end
  end
end
