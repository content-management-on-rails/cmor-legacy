module Cmor::Api
  class ApplicationController < ActionController::API
    include Cmor::Api::Controllers::I18nConcern
  end
end
