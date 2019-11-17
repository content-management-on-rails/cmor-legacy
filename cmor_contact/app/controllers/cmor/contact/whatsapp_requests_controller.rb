module Cmor
  module Contact
    class WhatsappRequestsController < Cmor::Contact::Configuration.base_controller.constantize
      before_action :initialize_resource, only: [:index, :new]
      before_action :initialize_resource_for_create, only: [:create]

      respond_to :html
      responders :flash

      def self.resource_class
        Cmor::Contact::WhatsappRequest
      end

      def index
        new
        if request.xhr?
          render :new_xhr, layout: false
        else
          render :new
        end
      end

      def new; end

      def create
        if @resource.valid?
          respond_with @resource, location: after_create_url
        else
          respond_with @resource
        end
      end

      private

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
        params.require(:whatsapp_request).permit(:message)
      end

      def after_create_url
        @resource.whatsapp_link
      end
    end
  end
end
