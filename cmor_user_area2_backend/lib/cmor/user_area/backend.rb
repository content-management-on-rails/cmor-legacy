require 'cmor/user_area/backend/configuration'
require 'cmor/user_area/backend/engine'

module Cmor
  module UserArea
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:user_area_backend, Cmor::UserArea::Backend) }