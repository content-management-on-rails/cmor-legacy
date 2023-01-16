require "acts_as_list"
require "acts_as_published"
require "friendly_id"
require "markup-rails"
require "cmor_core_backend"

require "cmor/testimonials/version"
require "cmor/testimonials/configuration"
require "cmor/testimonials/engine"

module Cmor
  module Testimonials
    def self.configure
      yield Configuration
    end
  end
end
