module Cmor
  module MultiTenancy
    module Controller
      # Example:
      #
      #     # app/controllers/application_controller.rb
      #     class ApplicationController < ActionController::Base
      #       include Cmor::MultiTenancy::Controller::CurrentClientConcern
      #
      #       around_action :set_current_client
      #     end
      #
      module CurrentClientConcern
        extend ActiveSupport::Concern

        included do
          helper_method :current_client if respond_to?(:helper_method)
        end
        
        private
        
        def current_client
          Cmor::MultiTenancy.current_client
        end

        def set_current_client
          if client = load_current_client
            with_client(client) { yield }
          else
            redirect_to_default_client
          end
        end

        def load_current_client
          if Cmor::MultiTenancy::Configuration.aliases_for_default_client.include?(current_client_identifier)
            load_default_client
          else
            ::Client.active.where(identifier: current_client_identifier).first
          end
        end

        def load_default_client
          ::Client.active.default.first!
        rescue ActiveRecord::RecordNotFound => e
          raise e.class.new "No active default client found. Please create a client with default: true or set the current client via ENV['client_identifier']"
        end

        def current_client_identifier
          params[:client_identifier] || ENV.fetch('client_identifier') { Cmor::MultiTenancy::Configuration.aliases_for_default_client.first }
        end

        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end

        def redirect_to_default_client
          redirect_to(current_client_key => load_default_client.identifier)
        end

        def current_client_key
          :subdomain
        end
      end
    end
  end
end
