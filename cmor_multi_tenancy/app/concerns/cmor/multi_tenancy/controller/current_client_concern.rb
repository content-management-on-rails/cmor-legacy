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
            ::Client.active.default.first!
          else
            ::Client.active.where(identifier: current_client_identifier).first
          end
        end

        def load_default_client
          ::Client.active.default.first!
        end

        def current_client_identifier
          if current_client_key == :subdomain
            request.host.split(".").first
          else
            # The delete_prefix call is needed due to a bug in route_translator where the generated
            # routes do not include the leading slash from the scope.
            params[:client_identifier]&.delete_prefix("/") || ENV.fetch('client_identifier') { Cmor::MultiTenancy::Configuration.aliases_for_default_client.first }
          end
        end

        def with_client(client)
          Cmor::MultiTenancy.with_client(client) { yield }
        end

        def redirect_to_default_client
          redirect_to(url_for(current_client_key => load_default_client.identifier), allow_other_host: true)
        end

        def current_client_key
          Cmor::MultiTenancy::Configuration.current_client_key
        end
      end
    end
  end
end
