module Cmor
  module Contact
    module Frontend
      class ApplicationController < ActionController::Base
        protect_from_forgery with: :exception
      end
    end
  end
end
