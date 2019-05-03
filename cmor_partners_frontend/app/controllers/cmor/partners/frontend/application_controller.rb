module Cmor::Partners::Frontend
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
  end
end
