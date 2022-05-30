module Cmor::Core::Api
  class ApplicationController < ActionController::API
    include ::Cmor::Core::Api::Controllers::I18nConcern
  end
end
