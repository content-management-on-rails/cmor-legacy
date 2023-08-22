require "active_storage_validations"
require "acts_as_list"
require "acts_as_published"
require "cmor-core-backend"
require "friendly_id"
require "markup-rails"

require "cmor/showcase/version"
require "cmor/showcase/configuration"
require "cmor/showcase/engine"

module Cmor
  module Showcase
    def self.configure
      yield Configuration
    end
  end
end
