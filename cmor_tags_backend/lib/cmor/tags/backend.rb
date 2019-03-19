require 'cmor/tags/backend/configuration'
require 'cmor/tags/backend/engine'

module Cmor
  module Tags
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:tags_backend, Cmor::Tags::Backend) }
