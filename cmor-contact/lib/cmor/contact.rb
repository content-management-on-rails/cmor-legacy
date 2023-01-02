require "cmor_core_backend"

require "cmor/contact/version"
require "cmor/contact/configuration"
require "cmor/contact/engine"

module Cmor
  module Contact
    def self.configure
      yield Configuration
    end
  end
end
