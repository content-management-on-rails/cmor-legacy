require "active_storage_validations"
require "acts_as_list"
require "acts_as_published"
require "friendly_id"

require "cmor-core"
require "cmor/core/model/collection_concern"
require "cmor/core/model/localization_concern"
require "cmor/core/model/identifier_concern"
require "cmor-core-backend"

require "cmor/galleries/version"
require "cmor/galleries/configuration"
require "cmor/galleries/engine"

module Cmor
  module Galleries
    def self.configure
      yield Configuration
    end
  end
end
