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
          RequestStore[:current_client]
        end

        def set_current_client
          RequestStore.store[:current_client] = load_current_client || load_default_client
          yield
          RequestStore.store[:current_client] = nil
        end

        def load_current_client
          Cmor::MultiTenancy::Client.active.where(identifier: params[:client_identifier]).first
        end

        def load_default_client
          Cmor::MultiTenancy::Client.active.default.first
        end
      end
    end
  end
end
