require 'cmor/galleries/configuration'
require "cmor/galleries/engine"
require "cmor/galleries/routes"

module Cmor
  module Galleries
    extend Configuration
  end
end

Cmor.configure { |c| c.register_configuration(:galleries, Cmor::Galleries) }
