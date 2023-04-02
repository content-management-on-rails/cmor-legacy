require "cmor/faq/version"
require "cmor/faq/configuration"
require "cmor/faq/engine"

module Cmor
  module Faq
    def self.configure
      yield Configuration
    end
  end
end
