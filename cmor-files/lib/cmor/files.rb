require "active_storage_validations"
require "acts_as_list"
require "acts_as_published"
require "cmor_core_backend"
require "friendly_id"

require "cmor/core/model/localization_concern"

require "cmor/files/version"
require "cmor/files/configuration"
require "cmor/files/engine"

module Cmor
  module Files
    def self.configure
      yield Configuration
    end
  end
end
