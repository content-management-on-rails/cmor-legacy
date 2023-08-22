require "active_storage_validations"
require "acts_as_list"
require "acts_as_published"
require "cmor-core-backend"
require "markup-rails"

require "cmor/carousels/version"
require "cmor/carousels/configuration"
require "cmor/carousels/engine"

module Cmor
  module Carousels
    def self.configure
      yield Configuration
    end
  end
end
