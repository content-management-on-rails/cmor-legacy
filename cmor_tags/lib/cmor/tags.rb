require 'cmor/tags/configuration'
require 'cmor/tags/engine'
require 'cmor/tags/routes'

module Cmor
  module Tags
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:tags, Cmor::Tags) }