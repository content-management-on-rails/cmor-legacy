# frozen_string_literal: true

require "cmor-core-backend"
require "paper_trail"

require "cmor/audits/version"
require "cmor/audits/configuration"
require "cmor/audits/engine"

module Cmor
  module Audits
    extend Configuration
  end
end
