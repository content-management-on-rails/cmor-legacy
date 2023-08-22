require "acts_as_list"
require "markup-rails"
require "awesome_nested_set"
require "awesome_nested_set-tools"
require "friendly_id"
require "RedCloth"

require "cmor-core-backend"

require "cmor/links/version"
require "cmor/links/configuration"
require "cmor/links/engine"

module Cmor
  module Links
    def self.configure
      yield Configuration
    end
  end
end
