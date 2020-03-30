module Cmor::MultiTenancy::Frontend
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
