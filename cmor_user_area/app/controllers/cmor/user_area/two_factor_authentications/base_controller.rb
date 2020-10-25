module Cmor
  module UserArea
    module TwoFactorAuthentications
      class BaseController < Cmor::UserArea::Configuration.base_controller.constantize
        include Rao::ServiceController::ServiceConcern
        include Rao::ServiceController::RestActionsConcern
        include Rao::ServiceController::RestServiceUrlsConcern
        include Rao::ServiceController::ServiceInflectionsConcern

        def create
          @result = execute_service
          if @result.ok?
            authenticable_session.create(@service.authenticable)
            session.delete(tfa_candidate_id_session_key)
            flash[:notice] = I18n.t('messages.success.cmor_user_area.signed_in') unless request.xhr?
            redirect_to(instance_eval(&Configuration.after_sign_in_url))
            return
          else
            render :new
          end
        end

        private

        def initialize_service_for_create
          super
          @service.authenticable = fetch_authenticable
        end

        def permitted_params
          params.require(service_class.name.demodulize.underscore).permit(:code)
        end

        def fetch_authenticable
          authenticable_class = @service.class.name.gsub("TwoFactorAuthentication", "").constantize
          id = tfa_candidate_id_session_key
          authenticable_class.find(id)
        end

        def tfa_candidate_id_session_key
          session["#{@service.class.name.gsub("TwoFactorAuthentication", "").underscore}_tfa_candidate_id"]
        end

        def authenticable_session
          "#{@service.class.name.gsub("TwoFactorAuthentication", "")}Session".constantize
        end
      end
    end
  end
end
