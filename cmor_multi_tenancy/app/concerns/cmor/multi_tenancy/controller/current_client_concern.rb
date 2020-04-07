module Cmor
  module MultiTenancy
    module Controller
      # Example:
      #
      #     # app/controllers/application_controller.rb
      #     class ApplicationController < ActionController::Base
      #       include Cmor::MultiTenancy::Controller::CurrentClientConcern
      #     end
      #
      module CurrentClientConcern
        extend ActiveSupport::Concern

        included do
          around_action :set_current_client

          helper_method :current_client
        end
        
        private
        
        def current_client
          Cmor::MultiTenancy.current_client
        end

        def set_current_client
          client = load_current_client || redirect_to_client
          with_client(client) { yield }
        end

        def load_current_client
          if Cmor::MultiTenancy::Configuration.aliases_for_default_client.include?(current_client_identifier)
            ::Client.active.default.first!
          else
            ::Client.active.where(identifier: current_client_identifier).first
          end
        end

        def load_default_client
          ::Client.active.default.first!
        end

        def current_client_identifier
          params[:client_identifier] || ENV.fetch('client_identifier')
        end

        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end

        def redirect_to_client
          redirect_to(current_client_key => load_default_client.identifier)
        end

        def current_client_key
          :subdomain
        end
      end
    end
  end
end
