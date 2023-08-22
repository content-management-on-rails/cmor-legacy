require "active_storage_validations"
require "acts_as_list"
require "acts_as_published"
require "friendly_id"
require "cmor-core"
require "cmor/core/model/localization_concern"
require "cmor-core-backend"
require "rao-service"

require "cmor/blog/version"
require "cmor/blog/configuration"
require "cmor/blog/engine"

module Cmor
  module Blog
    def self.configure
      yield Configuration
    end
  end
end
