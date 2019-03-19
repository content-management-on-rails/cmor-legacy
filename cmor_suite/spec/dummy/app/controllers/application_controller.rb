class ApplicationController < ActionController::Base
  # From CMOR Tags
  helper Cmor::Tags::ApplicationHelper
  
  include Cmor::UserArea::Controller::RedirectBackConcern
  include Cmor::UserArea::Controller::CurrentUserConcern

end
