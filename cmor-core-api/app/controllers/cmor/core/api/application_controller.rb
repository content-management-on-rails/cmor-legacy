module Cmor::Core::Api
  class ApplicationController < ActionController::API
    include ::Cmor::Core::Api::Controllers::I18nConcern
    include ::Cmor::Core::Api::Controllers::TokenAuthenticationConcern
  end
end
