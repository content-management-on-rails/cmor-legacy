module Cmor::Galleries
  class ApplicationController < Cmor::Galleries::Configuration.base_controller.constantize
    protect_from_forgery with: :exception
  end
end
