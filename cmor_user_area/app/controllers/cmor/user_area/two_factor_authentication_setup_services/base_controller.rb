module Cmor
  module UserArea
    module TwoFactorAuthenticationSetupServices
      class BaseController < Cmor::UserArea::Configuration.base_controller.constantize
        before_action :authenticate_user!

        include Rao::ServiceController::ServiceConcern
        include Rao::ServiceController::RestActionsConcern
        include Rao::ServiceController::RestServiceUrlsConcern
        include Rao::ServiceController::ServiceInflectionsConcern

        before_action :ensure_user_tfa_state!, only: [:new]

        private

        def success_message
          t('.success_message')
        end

        def after_success_location
          current_user_path
        end

        def permitted_params
          params.require(:two_factor_authentication_setup_service).permit(:code)
        end
  
        def initialize_service
          @service = service_class.new({ user: current_user }, service_options)
        end
  
        def initialize_service_for_create
          @service = service_class.new(hashified_params.merge(user: current_user), service_options)
        end

        def ensure_user_tfa_state!
          unless current_user.may_prepare_tfa? || current_user.may_enable_tfa?
            flash[:danger] = t('.not_available')
            redirect_back(fallback_location: current_user_path)
          else
            return true
          end
        end
      end
    end
  end
end