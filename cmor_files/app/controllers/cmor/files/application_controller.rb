module Cmor::Files
  class ApplicationController < Cmor::Files::Configuration.base_controller.constantize
    protect_from_forgery with: :exception
  end
end
