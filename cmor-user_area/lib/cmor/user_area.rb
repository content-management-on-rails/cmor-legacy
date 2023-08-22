require "aasm"
require "active_model_otp"
require "active_model_serializers"
require "authlogic"
require "bcrypt"
require "cmor-core-backend"
require "rao-service"

require "cmor/user_area/version"
require "cmor/user_area/configuration"
require "cmor/user_area/engine"

module Cmor
  module UserArea
    def self.configure
      yield Configuration
    end
  end
end
