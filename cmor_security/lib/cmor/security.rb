require 'cmor_core_backend'
require 'sassc-rails'
require 'tatoru_client'

require 'cmor/security/version'
require 'cmor/security/configuration'
require 'cmor/security/engine'

module Cmor
  module Security
    def self.configure
      yield Configuration
    end
  end
end
