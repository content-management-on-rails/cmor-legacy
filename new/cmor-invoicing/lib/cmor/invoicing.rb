require "money-rails"
require "wicked_pdf"
require "rao-service"

require "cmor/invoicing/version"
require "cmor/invoicing/configuration"
require "cmor/invoicing/engine"

module Cmor
  module Invoicing
    def self.configure
      yield Configuration
    end
  end
end
