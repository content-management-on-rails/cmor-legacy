# frozen_string_literal: true

module Cmor
  module Legal
    module Frontend
      class CookiePreferencesController < Cmor::Legal::Frontend::Configuration.base_controller.constantize
        include Rao::ResourcesController::LocationHistoryConcern

        if respond_to?(:before_action)
          before_action :initialize_resource, only: [:edit, :update]
        else
          before_filter :initialize_resource, only: [:edit, :update]
        end

        def edit
        end

        def update
          respond_to do |format|
            if @resource.update_attributes(permitted_params)
              format.html { redirect_to(after_update_location, notice: t(".success")) }
            else
              format.html { render :edit }
            end
          end
        end

        private

        def after_update_location
          last_location || main_app.root_path
        end

        def permitted_params
          if params.is_a?(ActiveSupport::HashWithIndifferentAccess)
            params[:cookie_preferences]
          else
            params.fetch(:cookie_preferences, {}).permit(@resource.cookies.map(&:identifier))
          end
        end

        def initialize_resource
          @resource = ::Cmor::Legal::CookiePreferences.new(cookie_store: ::Cmor::Legal::CookieStore.new(send(::Cmor::Legal::Configuration.cookie_storage)))
        end
      end
    end
  end
end
