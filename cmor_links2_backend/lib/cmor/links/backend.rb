require 'cmor/links/backend/configuration'
require 'cmor/links/backend/engine'

module Cmor
  module Links
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:links_backend, Cmor::Links::Backend) }