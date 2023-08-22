require "acts_as_list"
require "acts_as_published"
require "cmor-core-backend"
require "markup-rails"

require "cmor/partners/version"
require "cmor/partners/configuration"
require "cmor/partners/engine"

module Cmor
  module Partners
    extend Configuration
  end
end
