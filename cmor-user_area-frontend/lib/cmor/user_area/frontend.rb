require "cmor-core-frontend"
require "cmor-user_area"
require "rqrcode"

require "cmor/user_area/frontend/version"
require "cmor/user_area/frontend/configuration"
require "cmor/user_area/frontend/engine"

module Cmor
  module UserArea
    module Frontend
      def self.configure
        yield Configuration
      end
    end
  end
end
