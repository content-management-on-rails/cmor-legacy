require 'cmor/files/backend/configuration'
require "cmor/files/backend/engine"

module Cmor
  module Files
    module Backend
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:files_backend, Cmor::Files::Backend) }