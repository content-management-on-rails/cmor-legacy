class ApplicationController < ActionController::Base
  # From ECM Tags
  helper Cmor::Tags::ApplicationHelper
  
  include Cmor::UserArea::Controller::RedirectBackConcern
  include Cmor::UserArea::Controller::CurrentUserConcern

end
