module Cmor::Contact::Api
  class ContactRequestsController < Cmor::Contact::Api::ResourcesController::Base
    def self.resource_class
      Cmor::Contact::ContactRequest
    end

    def self.serializer_class
      Cmor::Contact::Api::ContactRequestSerializer
    end

    private

    def initialize_resource_for_create
      super
      @resource.ip_address = request.remote_ip
    end

    def permitted_params
      # Allow only available attributes and add nickname for spam protection.
      attrs = (
        resource_class.attribute_names.map(&:to_sym) & [:nickname, :name, :email, :phone, :subject, :message, :accept_terms_of_service]
      ) + [:nickname]
      params.require(:contact_request).permit(attrs)
    end
  end
end
