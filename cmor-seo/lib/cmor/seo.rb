require "acts_as_list"
require "acts_as_published"
require "cmor_core_backend"
require "cocoon"
require "rao-or_validator"
require "rao-service"
require "simple_form-polymorphic_associations"

require "cmor/seo/version"
require "cmor/seo/configuration"
require "cmor/seo/engine"

module Cmor
  module Seo
    def self.configure
      yield Configuration
    end
  end
end
