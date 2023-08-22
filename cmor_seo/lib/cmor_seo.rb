# frozen_string_literal: true

require "cmor-core"
require "cmor-core-backend"
require "acts_as_list"
require "acts_as_published"
require "simple_form-polymorphic_associations"
require "cocoon"
require "rao-service"
require "rao-or_validator"

require "cmor/seo/version"
require "cmor/seo/configuration"
require "cmor/seo/engine"

module Cmor
  module Seo
    extend Configuration
  end
end
