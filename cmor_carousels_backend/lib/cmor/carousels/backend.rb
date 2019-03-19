require 'cmor/carousels/backend/configuration'
require "cmor/carousels/backend/engine"

module Cmor
  module Carousels
    module Backend
      # Your code goes here...
      extend Configuration
    end
  end
end

Cmor.configure { |c| c.register_configuration(:carousels_backend, Cmor::Carousels::Backend) }