require 'cmor/files/configuration'
require "cmor/files/engine"
require "cmor/files/routes"

module Cmor
  module Files
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:files, Cmor::Files) }