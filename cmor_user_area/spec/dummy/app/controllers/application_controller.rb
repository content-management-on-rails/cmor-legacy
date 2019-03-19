class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper Cmor::UserAreaHelper

  include Controller::CurrentUserConcern  
  # From CMOR User Area
  include Controller::RedirectBackConcern
  include Controller::CurrentUserConcern

end
