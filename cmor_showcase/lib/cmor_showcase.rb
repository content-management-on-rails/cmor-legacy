require "cmor_core"
require "cmor_core_backend"
require "active_storage_validations"
require "acts_as_published"
require "acts_as_list"
require "friendly_id"
require "markup-rails"

require "cmor/showcase/version"
require "cmor/showcase/configuration"
require "cmor/showcase/engine"

module Cmor
  module Showcase
    extend Configuration
  end
end
