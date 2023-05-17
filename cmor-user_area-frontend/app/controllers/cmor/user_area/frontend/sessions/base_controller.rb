module Cmor
  module UserArea
    module Frontend
      module Sessions
        class BaseController < Cmor::UserArea::Frontend::Configuration.base_controller.constantize
          include Rao::ResourcesController::ResourcesConcern
          include Rao::ResourcesController::ResourceInflectionsConcern
          include Rao::ResourcesController::RestResourceUrlsConcern
          include Rao::ResourcesController::RestActionsConcern
          include Rao::ResourcesController::LocationHistoryConcern

          skip_before_action :authenticate_user!, only: [:new, :create], raise: false
          skip_before_action :store_location, only: [:new, :create]

          protect_from_forgery with: :null_session, if: -> { request.format.json? }
          skip_before_action :verify_authenticity_token, if: -> { request.format.json? }


          def new
            @session = initialize_resource
            respond_with @session
          end

          def create
            @session = resource_class.new(permitted_params)

            if @session.valid?
              if Cmor::UserArea::Configuration.tfa_enabled? && @session.attempted_record.has_tfa?
                session["#{@session.attempted_record.class.name.underscore}_tfa_candidate_id"] = @session.attempted_record.id
                respond_to do |format|
                  format.html { redirect_to new_user_two_factor_authentications_path }
                  # respond with 501 Not Implemented for now
                  format.json { render json: { error: "Not Implemented" }, status: :not_implemented }
                end
              else
                @session.save!
                respond_to do |format|
                  format.html do
                    flash[:notice] = I18n.t("messages.success.cmor_user_area_frontend.signed_in") unless request.xhr?
                    redirect_to(instance_eval(&Configuration.after_sign_in_url))
                  end
                  format.json { render json: @session.attempted_record, status: :ok }
                end
              end
              nil
            else
              respond_to do |format|
                format.html { render action: :new }
                format.json { render json: { error: @session.errors.full_messages.join(", ") }, status: :unauthorized }
              end
            end
          end

          def destroy
            current_session(resource_class.name.demodulize.underscore.to_sym).destroy
            flash[:notice] = I18n.t("messages.success.cmor_user_area_frontend.signed_out") unless request.xhr?
            redirect_to after_sign_out_url
          end

          def self.resource_class
            fail "please define self.session_class in your controller."
          end

          private

          def permitted_params
            if Rails.version < "5"
              params.require(resource_class.name.demodulize.underscore.tr("/", "_")).permit(:email, :password)
            else
              params.require(resource_class.name.demodulize.underscore.tr("/", "_")).permit(:email, :password).to_h
            end
          end
        end
      end
    end
  end
end
