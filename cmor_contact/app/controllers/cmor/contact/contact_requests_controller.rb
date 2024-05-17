module Cmor
  module Contact
    class ContactRequestsController < Cmor::Contact::Configuration.base_controller.constantize
      before_action :initialize_resource, only: [:index, :new]
      before_action :initialize_resource_for_create, only: [:create]

      respond_to :html
      respond_to :js
      responders :flash

      def self.resource_class
        Cmor::Contact::ContactRequest
      end

      def index
        new
        render :new
      end

      def new; end

      def create
        @resource.ip_address = request.remote_ip
        if before_save && @resource.save
          respond_with @resource, location: after_create_url
        else
          respond_with @resource
        end
      end

      private

      def before_save
        if Cmor::Contact::Configuration.spam_protection == :google_recaptcha_v2
          return verify_recaptcha(model: @resource)
        end

        if Cmor::Contact::Configuration.spam_protection == :google_recaptcha_v3
          unless verify_recaptcha(action: 'create/contact_request/contact/cmor', minimum_score: 0.5, secret_key: Recaptcha.configuration.secret_key)
            @resource.valid?
            @resource.errors.add(:base, flash[:recaptcha_error])
            flash.delete(:recaptcha_error)
            return false
          end
        end

        true
      end

      def initialize_resource_for_create
        @resource = initialize_scope.new(permitted_params)
      end

      def initialize_resource
        @resource = initialize_scope.new
      end

      def initialize_scope
        resource_class
      end

      def resource_class
        self.class.resource_class
      end

      def permitted_params
        # Allow only available attributes and add nickname for spam protection.
        attrs = (
          resource_class.attribute_names.map(&:to_sym) & [:nickname, :name, :email, :phone, :subject, :message, :accept_terms_of_service]
        ) + [:nickname]
        params.require(:contact_request).permit(attrs)
      end

      def after_create_url
        Cmor::Contact::Configuration.after_create_url.call(self)
      end
    end
  end
end
